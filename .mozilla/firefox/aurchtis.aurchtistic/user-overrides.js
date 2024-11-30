/*** [SECTION 0700]: DNS / DoH / PROXY / SOCKS ***/
user_pref("network.trr.mode", 2); // enable dns over https
user_pref("network.trr.uri", "https://base.dns.mullvad.net/dns-query"); // custom dns needs to be the same for both entries
user_pref("network.trr.custom_uri", "https://base.dns.mullvad.net/dns-query");


/*** [SECTION 2800]: SHUTDOWN & SANITIZING ***/
user_pref("privacy.clearOnShutdown.history", false); // retain history
user_pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", false); // retain history


/*** [SECTION 5000]: OPTIONAL OPSEC ***/
user_pref("signong.remember.Signons", false); // disable saving passwords
user_pref("browser.chrome.site_icons", true);
user_pref("browser.sessionstore.max_tabs_undo", 5);
user_pref("browser.sessionstore.resume_from_crash", true);
user_pref("browser.urlbar.suggest.history", true);
user_pref("browser.urlbar.suggest.bookmark", true);
user_pref("browser.urlbar.suggest.topsites", false); // do not suggest top sites 
user_pref("keyword.enabled", true); // search from the urlbar
