{ config, ... }: {
  xdg.configFile = {
    "qt5ct/qt5ct.conf".text = ''
      [Appearance]
      color_scheme_path=${config.home.homeDirectory}/.config/qt5ct/colors/Gruvbox-Retro.conf
      custom_palette=true
      icon_theme=Gruvbox-Plus-Dark
      standard_dialogs=default
      style=kvantum-dark

      [Fonts]
      fixed="JetBrainsMono Nerd Font,9,-1,5,50,0,0,0,0,0,Regular"
      general="Cantarell,10,-1,5,50,0,0,0,0,0"

      [Interface]
      activate_item_on_single_click=1
      buttonbox_layout=0
      cursor_flash_time=1000
      dialog_buttons_have_icons=0
      double_click_interval=400
      gui_effects=@Invalid()
      keyboard_scheme=2
      menus_have_icons=true
      show_shortcuts_in_context_menus=true
      stylesheets=@Invalid()
      toolbutton_style=4
      underline_shortcut=2
      wheel_scroll_lines=4

      [SettingsWindow]
      geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\x1\x66\0\0\0\x8a\0\0\x6\x19\0\0\x3\xad\0\0\x4\xa1\0\0\0\x14\0\0\a\x7f\0\0\x2\xb3\0\0\0\0\x2\0\0\0\a\x80\0\0\x1h\0\0\0\x8c\0\0\x6\x17\0\0\x3\xab)

      [Troubleshooting]
      force_raster_widgets=1
      ignored_applications=/usr/bin/strawberry
    '';

    "qt6ct/qt6ct.conf".text = ''
      [Appearance]
      color_scheme_path=${config.home.homeDirectory}/.config/qt6ct/colors/Gruvbox-Retro.conf
      custom_palette=true
      icon_theme=Gruvbox-Plus-Dark
      standard_dialogs=default
      style=kvantum-dark

      [Fonts]
      fixed="JetBrainsMono Nerd Font,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
      general="Cantarell,10,-1,5,300,0,0,0,0,0,0,0,0,0,0,1"

      [Interface]
      activate_item_on_single_click=1
      buttonbox_layout=0
      cursor_flash_time=1000
      dialog_buttons_have_icons=0
      double_click_interval=400
      gui_effects=@Invalid()
      keyboard_scheme=2
      menus_have_icons=true
      show_shortcuts_in_context_menus=true
      stylesheets=@Invalid()
      toolbutton_style=4
      underline_shortcut=1
      wheel_scroll_lines=4

      [PaletteEditor]
      geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\a\x80\0\0\0\0\0\0\t\xf6\0\0\x2\x10\0\0\a\x80\0\0\0\0\0\0\t\xf6\0\0\x2\x10\0\0\0\0\x2\0\0\0\a\x80\0\0\a\x80\0\0\0\0\0\0\t\xf6\0\0\x2\x10)

      [SettingsWindow]
      geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\x1\x66\0\0\0\x8a\0\0\x6\x19\0\0\x3\xad\0\0\x3\xbf\0\0\0\x19\0\0\a~\0\0\x4\x34\0\0\0\0\x2\0\0\0\a\x80\0\0\x1h\0\0\0\x8c\0\0\x6\x17\0\0\x3\xab)

      [Troubleshooting]
      force_raster_widgets=1
      ignored_applications=@Invalid()
    '';

    "xfce4/helpers.rc".text = ''
      TerminalEmulator=alacritty
    '';

    "mimeapps.list".text = ''
      [Added Associations]
      application/json=nvim.desktop;code.desktop;firefox.desktop;
      application/x-sh=nvim.desktop;code.desktop;
      application/x-shellscript=nvim.desktop;code.desktop;
      application/xml=nvim.desktop;code.desktop;
      application/yaml=nvim.desktop;code.desktop;
      image/*=com.interversehq.qView.desktop;imv-dir.desktop;
      image/apng=com.interversehq.qView.desktop;imv-dir.desktop;
      image/avif=com.interversehq.qView.desktop;imv-dir.desktop;
      image/gif=com.interversehq.qView.desktop;imv-dir.desktop;
      image/jpeg=com.interversehq.qView.desktop;imv-dir.desktop;
      image/pjpeg=com.interversehq.qView.desktop;imv-dir.desktop;
      image/png=com.interversehq.qView.desktop;imv-dir.desktop;
      image/svg+xml=com.interversehq.qView.desktop;imv-dir.desktop;
      image/vnd.microsoft.icon=com.interversehq.qView.desktop;imv-dir.desktop;
      image/webp=com.interversehq.qView.desktop;imv-dir.desktop;
      image/x-icon=com.interversehq.qView.desktop;imv-dir.desktop;
      text/*=nvim.desktop;code.desktop;
      text/css=nvim.desktop;code.desktop;
      text/csv=nvim.desktop;code.desktop;
      text/html=nvim.desktop;code.desktop;firefox.desktop;
      text/javascript=nvim.desktop;code.desktop;
      text/markdown=nvim.desktop;code.desktop;
      text/plain=nvim.desktop;code.desktop;
      text/x-asm=nvim.desktop;code.desktop;
      text/x-c=nvim.desktop;code.desktop;
      text/x-python=nvim.desktop;code.desktop;

      [Default Applications]
      application/json=nvim.desktop;code.desktop;firefox.desktop;
      application/pdf=org.gnome.Evince.desktop;
      application/x-bittorrent=qbittorrent.desktop;
      application/x-extension-htm=firefox.desktop;
      application/x-extension-html=firefox.desktop;
      application/x-extension-shtml=firefox.desktop;
      application/x-extension-xht=firefox.desktop;
      application/x-extension-xhtml=firefox.desktop;
      application/x-sh=nvim.desktop;code.desktop;
      application/x-shellscript=nvim.desktop;code.desktop;
      application/x-zerosize=nvim.desktop;code.desktop;
      application/xhtml+xml=firefox.desktop;
      application/xml=nvim.desktop;code.desktop;
      application/yaml=nvim.desktop;code.desktop;
      application/zip=ark.desktop;
      audio/*=mpv.desktop;
      audio/aac=mpv.desktop;
      audio/flac=mpv.desktop;
      audio/mp4=mpv.desktop;
      audio/mpeg=mpv.desktop;
      audio/ogg=mpv.desktop;
      audio/opus=mpv.desktop;
      audio/vnd.wav=mpv.desktop;
      audio/webm=mpv.desktop;
      audio/x-matroska=mpv.desktop;
      audio/x-mpegurl=mpv.desktop;
      audio/x-opus+ogg=mpv.desktop;
      image/*=com.interversehq.qView.desktop;imv-dir.desktop;
      image/apng=com.interversehq.qView.desktop;imv-dir.desktop;
      image/avif=com.interversehq.qView.desktop;imv-dir.desktop;
      image/gif=com.interversehq.qView.desktop;imv-dir.desktop;
      image/jpeg=com.interversehq.qView.desktop;imv-dir.desktop;
      image/pjpeg=com.interversehq.qView.desktop;imv-dir.desktop;
      image/png=com.interversehq.qView.desktop;imv-dir.desktop;
      image/svg+xml=com.interversehq.qView.desktop;imv-dir.desktop;
      image/vnd.microsoft.icon=com.interversehq.qView.desktop;imv-dir.desktop;
      image/webp=com.interversehq.qView.desktop;imv-dir.desktop;
      image/x-icon=com.interversehq.qView.desktop;imv-dir.desktop;
      inode/directory=thunar.desktop;
      text/*=nvim.desktop;code.desktop;
      text/css=nvim.desktop;code.desktop;
      text/csv=nvim.desktop;code.desktop;
      text/html=firefox.desktop;nvim.desktop;code.desktop;
      text/javascript=nvim.desktop;code.desktop;
      text/markdown=nvim.desktop;code.desktop;
      text/plain=nvim.desktop;code.desktop;
      text/x-asm=nvim.desktop;code.desktop;
      text/x-c=nvim.desktop;code.desktop;
      text/x-python=nvim.desktop;code.desktop;
      video/*=mpv.desktop;
      video/mp4=mpv.desktop;
      video/mpeg=mpv.desktop;
      video/quicktime=mpv.desktop;
      video/webm=mpv.desktop;
      video/x-matroska=mpv.desktop;
      x-scheme-handler/about=firefox.desktop;
      x-scheme-handler/chrome=firefox.desktop;
      x-scheme-handler/http=firefox.desktop;
      x-scheme-handler/https=firefox.desktop;
      x-scheme-handler/jetbrains=jetbrains-toolbox.desktop;
      x-scheme-handler/magnet=qbittorrent.desktop;
      x-scheme-handler/mailto=thunderbird.desktop;
      x-scheme-handler/unknown=firefox.desktop;

      [Removed Associations]
    '';

    "qt5ct/colors".source = ../../../assets/qt5ct/colors;
    "qt6ct/colors".source = ../../../assets/qt6ct/colors;
    "Kvantum".source = ../../../assets/Kvantum;
  };
}