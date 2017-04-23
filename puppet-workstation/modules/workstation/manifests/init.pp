class workstation() {
	$global_packages = [
		"git",
		"ruby",
		"vagrant",
		"filezilla",
		"openvpn",
		"keepass",

	]
	$win_packages = [
		"sourcetree",
		"virtualbox",
		"mobaxterm",
		"notepadplusplus.install",
		"7zip",
		"netbeans-jee",
		"sysinternals",
		"powershell",
		"ruby2.devkit",
		"syncthing",
		"syncthing-gtk",
		"putty",
		"slack",
		"vmwarevsphereclient",
	]
	$nix_packages = [
		"dwm",
		"dunst",
		"feh",
		"autoconf",
		"gcc",
		"gcc-devel",
		"firefox",
		"inkscape",
		"blender",
		"quassel",
		"nmap",
		"bash",
		"krdc",
		"libgdiplus",
		"gitflow",
		"sudo",
		"shutter",
		"synergy",
		"x11vnc",
		"dmenu",
		"lxterminal",
		"i3lock",
    "i3",
		"i3status",
		"grive2",
		"nano",
		"htop",
		"screen",
		"tmux",
		"blueman",
		"volumeicon",
		"kleopatra"
	]
	case downcase($osfamily) {
		"windows" : {
			$packages = $global_packages + $win_packages
			include ::chocolatey
			$package_provider = "chocolatey"
		}
		"freebsd" : {
			$freebsd_packages = [
				"virtualbox-ose",
				"syncthing",
				"netbeans",
				"gimp-app",
				"mono",
				"docker-freebsd",
				"zxfer",
				"iocage",
				"chromium",
			]
			$packages = $global_packages + $nix_packages + $freebsd_packages
			$package_provider = "pkgng"
#			file { "/usr/local/bin/dwm-syn":
#				source => "puppet:///modules/workstation/dwm-syn",
#				mode => "755",
#				owner => "root",
#			}
#			file { "/usr/local/share/xsessions/49dwm.desktop":
#				source => "puppet:///modules/workstation/49dwm.desktop",
#				mode => "755",
#				owner => "root",
#			}
		}
		"redhat" : {
			$rhel_packages = [
				"mono-core",
				"gimp",
				"docker",
				"vim-enhanced",
				"ruby-devel",
				"libffi-devel",
				"python2-sphinx",
				"PyYAML",
				"redhat-rpm-config",
				"zlib-devel",
				"gcc-c++",
				"libjpeg-devel",
				"python-devel",
			]
			package { 'lsb': }
			package { 'libXScreenSaver': }
			package { "google-chrome":
				source   => 'https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm',
				provider => 'rpm',
			}
			$url = "http://download.virtualbox.org/virtualbox/5.1.20/VirtualBox-5.1-5.1.20_114628_fedora25-1.x86_64.rpm"
			package { "Virtualbox":
				source   => $url,
				provider => 'rpm',
			}
			$packages = $global_packages + $nix_packages + $rhel_packages
			$package_provider = "yum"
			/* file { "/usr/local/bin/dwm-syn": */
			/* 	source => "puppet:///modules/workstation/dwm-syn", */
			/* 	mode => "755", */
			/* 	owner => "root", */
			/* } */
			/* file { "/usr/share/xsessions/49dwm.desktop": */
			/* 	source => "puppet:///modules/workstation/49dwm.desktop", */
			/* 	mode => "755", */
			/* 	owner => "root", */
			/* } */
			group { "docker":
				ensure => present,
			} ->
			service { "docker":
				enable => "true",
				ensure => "running",
			}
		}
	}
	package { $packages:
		ensure => "installed",
		provider => $package_provider,
	}
}
