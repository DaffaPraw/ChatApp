import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting {
  final String title;
  final String route;
  final String routes;
  final IconData icon;

  Setting({
    required this.title,
    required this.route,
    required this.routes,
    required this.icon,
  });
}

final List<Setting> settings = [
  Setting(
    title: "Personal Data",
    route: "/",
    routes: "/personal",
    icon: CupertinoIcons.person_fill,
  ),
  Setting(
    title: "Notifications",
    route: "/",
    routes: "/notification",
    icon: CupertinoIcons.bell_solid,
  ),
  Setting(
    title: "Data Usage",
    route: "/",
    routes: "/datausage",
    icon: Icons.sync_alt,
  ),
  Setting(
    title: "Language",
    route: "/",
    routes: "/lang",
    icon: Icons.language,
  ),
];

final List<Setting> settings2 = [
  Setting(
    title: "Sync",
    route: "/",
    routes: "/sync",
    icon: Icons.sync,
  ),
  Setting(
    title: "Help",
    route: "/",
    routes: "/personal",
    icon: Icons.help,
  ),
  Setting(
    title: "Log-Out",
    route: "/",
    routes: "/logout",
    icon: Icons.logout,
  ),
];

final List<Setting> settings3 = [
  Setting(
    title: "Username",
    route: "/",
    routes: "/personal",
    icon: Icons.account_box,
  ),
  Setting(
    title: "Phone Number",
    route: "/",
    routes: "/personal",
    icon: CupertinoIcons.phone_fill,
  ),
  Setting(
    title: "Email",
    route: "/",
    routes: "/personal",
    icon: CupertinoIcons.envelope_fill,
  ),
  Setting(
    title: "Two-step Verification",
    route: "/",
    routes: "/personal",
    icon: CupertinoIcons.checkmark_seal_fill,
  ),
];

final List<Setting> settings4 = [
  Setting(
    title: "Chat",
    route: "/",
    routes: "/notification",
    icon: Icons.chat,
  ),
  Setting(
    title: "Call",
    route: "/",
    routes: "/notification",
    icon: Icons.phone_in_talk_rounded,
  ),
  Setting(
    title: "Tagged",
    route: "/",
    routes: "/notification",
    icon: Icons.assignment_ind,
  ),
  Setting(
    title: "DND",
    route: "/",
    routes: "/notification",
    icon: Icons.dnd_forwardslash,
  ),
];

final List<Setting> settings5 = [
  Setting(
    title: "When Using Mobile Data",
    route: "/",
    routes: "/datausage",
    icon: Icons.network_cell_outlined,
  ),
  Setting(
    title: "When Using Wi-Fi",
    route: "/",
    routes: "/datausage",
    icon: Icons.wifi,
  ),
  Setting(
    title: "When Roaming",
    route: "/",
    routes: "/datausage",
    icon: Icons.mode_of_travel,
  ),
  Setting(
    title: "Proxy",
    route: "/",
    routes: "/datausage",
    icon: Icons.cloud,
  ),
];
