import Gio from 'gi://Gio';
import GLib from 'gi://GLib';

import {Extension} from 'resource:///org/gnome/shell/extensions/extension.js';
import * as Main from 'resource:///org/gnome/shell/ui/main.js';

const OBJECT_PATH = '/org/gnome/Shell/Extensions/AlacrittyToggle';

const IFACE = `
<node>
  <interface name="org.gnome.Shell.Extensions.AlacrittyToggle">
    <method name="Toggle">
      <arg type="s" name="wmClass" direction="in"/>
      <arg type="s" name="command" direction="in"/>
    </method>
    <method name="Status">
      <arg type="s" name="wmClass" direction="in"/>
      <arg type="s" name="json" direction="out"/>
    </method>
  </interface>
</node>`;

// Match a window's wm_class / instance case-insensitively.
function matches(win, needle) {
    const wc = (win.get_wm_class() || '').toLowerCase();
    const inst = (win.get_wm_class_instance?.() || '').toLowerCase();
    return wc === needle || inst === needle;
}

function windowsFor(needle) {
    return global.get_window_actors()
        .map(a => a.meta_window)
        .filter(w => w && matches(w, needle));
}

export default class AlacrittyToggleExtension extends Extension {
    enable() {
        this._dbus = Gio.DBusExportedObject.wrapJSObject(IFACE, this);
        this._dbus.export(Gio.DBus.session, OBJECT_PATH);
    }

    disable() {
        this._dbus?.unexport();
        this._dbus = null;
    }

    // Hammerspoon-equivalent behaviour:
    //   focused  -> minimize (hide)
    //   exists   -> activate (raise + focus, switching workspace if needed)
    //   missing  -> launch `command`
    Toggle(wmClass, command) {
        const needle = (wmClass || '').toLowerCase();
        if (!needle)
            return;

        const wins = windowsFor(needle);

        if (wins.length === 0) {
            if (command) {
                try {
                    GLib.spawn_command_line_async(command);
                } catch (e) {
                    logError(e, 'AlacrittyToggle: failed to launch ' + command);
                }
            }
            return;
        }

        const focus = global.display.focus_window;
        const focused = focus && matches(focus, needle);

        if (focused) {
            wins.forEach(w => w.minimize());
            return;
        }

        // Activate the most-recently-used matching window.
        const target = wins.sort((a, b) => b.get_user_time() - a.get_user_time())[0];
        Main.activateWindow(target);
    }

    // Debug helper: JSON snapshot of matching windows.
    Status(wmClass) {
        const needle = (wmClass || '').toLowerCase();
        const focus = global.display.focus_window;
        const wins = windowsFor(needle).map(w => ({
            wm_class: w.get_wm_class(),
            instance: w.get_wm_class_instance?.() ?? null,
            title: w.get_title(),
            minimized: w.minimized,
            focused: focus === w,
        }));
        return JSON.stringify({count: wins.length, windows: wins});
    }
}
