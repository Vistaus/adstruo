/*
* Copyright (c) 2019 Raí B. Toffoletto (https://toffoletto.me)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Raí B. Toffoletto <rai@toffoletto.me>
*/
public class Adstruo.Plug : Switchboard.Plug {
    private Gtk.Paned main_panel;

    public Plug () {
        Object (category: Category.PERSONAL,
                code_name: "adstruo",
                display_name: _("Aditional Indicators"),
                description: _("Manage aditional indicators for wingpanel."),
                icon: "com.github.raibtoffoletto.adstruo",
                supported_settings: new Gee.TreeMap<string, string?> (null, null)
                );
        supported_settings.set ("adstruo", null);
    }

    public override Gtk.Widget get_widget () {
        main_panel = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);

        //list of indicators available
        var settings_temps = new Adstruo.SettingsTemps ();
        var settings_weather = new Adstruo.SettingsWeather ();

        //add panels to paned widget
        var main_settings = new GLib.Settings ("com.github.raibtoffoletto.adstruo");

        var stack = new Gtk.Stack ();
            stack.add_named (settings_temps, "adstruo-temps");
            stack.add_named (settings_weather, "adstruo-weather");

        var sidebar = new Granite.SettingsSidebar (stack);

        main_panel.add (sidebar);
        main_panel.add (stack);
        main_panel.show_all ();

        stack.set_visible_child_name (main_settings.get_string ("settings-to-open"));
        //BUG: Settings sidebar won't be selected... can't figure out a way to set visible_child_name that worked


        return main_panel;
    }

    public override void shown () {
    }

    public override void hidden () {
    }

    public override void search_callback (string location) {
    }

    public override async Gee.TreeMap<string, string> search (string search) {
        return new Gee.TreeMap<string, string> (null, null);
    }
}

public Switchboard.Plug get_plug (Module module) {
    debug (_("Activating Adstruo Options plugin"));
    var plug = new Adstruo.Plug ();
    return plug;
}
