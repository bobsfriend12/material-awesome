return {
	-- Widget configurations
	widget = {
		weather = {
			-- API Key
			key = '485689562fd669455c5ae4c8dddeb749',

			-- City ID
			city_id = '4906125',

			-- Units
			units = 'imperial',

			-- Update in N seconds
			update_interval = 60,

			-- Use 12hr time
			time_format_12h = true,

			-- Show Hourly Forecast
			show_hourly_forecast = true,

			-- Show daily forecast
    		show_daily_forecast = true
		},

		-- Yes I use military time by default, deal with it ;) (or just disable it)
		clock = {
			-- Clock widget format
			military_mode = false
		},

		-- I do not use the widgets for the below configurations, but I left them here in-case you re-enable them!
		screen_recorder = {
			-- Default record dimension
			resolution = '1366x768',
			-- X,Y coordinate
			offset = '0,0',
			-- Enable audio by default
			audio = false,
			-- Recordings directory
			save_directory = '$(xdg-user-dir VIDEOS)/Recordings/',
			-- Mic level
			mic_level = '20',
			-- FPS
			fps = '30'
		},

		network = {
			-- Wired interface
			wired_interface = 'enp5s0',
			-- Wireless interface
			wireless_interface = 'wlan0'
		},

		email  = {
			-- Email address
			address = '',
			-- App password
			app_password = '',
			-- Imap server
			imap_server = 'imap.gmail.com',
			-- Port
			port = '993'
		}
	},

	-- Module configurations
	module = {
		auto_start = {
			-- Will create notification if true
			debug_mode = false
		},

		dynamic_wallpaper = {
			-- Will look for wallpapers here
			wall_dir = 'theme/wallpapers/',
			-- Image formats
			valid_picture_formats = {'jpg', 'png', 'jpeg'},
			-- Leave this table empty for full auto scheduling
			wallpaper_schedule = {
				['00:00:00'] = 'midnight-wallpaper.png',
				['06:22:00'] = 'morning-wallpaper.png',
				['12:00:00'] = 'noon-wallpaper.png',
				['17:58:00'] = 'night-wallpaper.png'
				-- Example of just using auto-scheduling with keywords
				--[[
					'midnight',
					'morning',
					'noon',
					'afternoon',
					'evening',
					'night'
				--]]
			},
			-- Stretch background image across all screens(monitor)
			stretch = true
		},

		-- This module is not in use, configuration is left here for potential future use!
		-- because this idea is actually really cool!
		lockscreen = {
			-- Clock format
			military_clock = false,
			-- Default password if there's no PAM integration
			fallback_password = 'toor',
			-- Capture intruder using webcam
			capture_intruder = true,
			-- Intruder image save location (Will create directory if it doesn't exist)
			face_capture_dir = '$(xdg-user-dir PICTURES)/Intruders/',
			-- Background directory - Defaults to 'awesome/config/theme/wallpapers/' if null
			bg_dir = nil,
			-- Will look for this image file under 'bg_dir'
			bg_image = 'locksreen-bg.jpg',
			-- Blur lockscreen background
			blur_background = false,
			-- Blurred/filtered background image path (No reason to change this)
			tmp_wall_dir = '/tmp/awesomewm/' .. os.getenv('USER') .. '/'
		}
	}
}
