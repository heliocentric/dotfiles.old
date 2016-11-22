class workstation() {
	case downcase($osfamily) {
		"windows" : {
			$packages = [
				"sourcetree",
				"vagrant",
				"virtualbox",
				"mobaxterm",
				"notepadplusplus.install",
				"git",
				"7zip",
				"netbeans-jee",
				"sysinternals",
				"powershell",
				"filezilla",
				"ruby",
				"ruby2.devkit",
				"keepass",
				"syncthing",
				"syncthing-gtk",
				"putty",
				"slack",
				"vmwarevsphereclient",
			]
			include ::chocolatey
			$package_provider = "chocolatey"
		}
		"freebsd" : {
			$packages = [
				"dwm",
				"chromium",
				"firefox",
				"netbeans",
				"inkscape",
				"gimp-app",
				"blender",
				"quassel",
				"nmap",
				"bash",
				"krdc",
				"mono",
				"libgdiplus",
				"keepass",
				"openvpn",
				"gitflow",
				"sudo",
				"shutter",
				"virtualbox-ose",
				"vagrant",
				"docker-freebsd",
				"synergy",
				"syncthing",
				"iocage",
				"x11vnc",
				"dmenu",
				"lxterminal",
				"zxfer",
				"slock",
			]
			$package_provider = "pkgng"
			file { "/usr/local/bin/vnc":
				source => "puppet:///modules/workstation/vnc",
				mode => "755",
				owner => "root",
			}
			file { "/usr/local/bin/novnc":
				source => "puppet:///modules/workstation/novnc",
				mode => "755",
				owner => "root",
			}
			file { "/usr/local/bin/dwm-syn":
				source => "puppet:///modules/workstation/dwm-syn",
				mode => "755",
				owner => "root",
			}
			file { "/usr/local/share/xsessions/49dwm.desktop":
				source => "puppet:///modules/workstation/49dwm.desktop",
				mode => "755",
				owner => "root",
			}
		}
	}
	package { $packages:
		ensure => "installed",
		provider => $package_provider,
	}
}
