# shellcheck shell=bash disable=SC2034
####################################################################################################
# This is a bubble theme created by @embe221ed (https://github.com/embe221ed)
# colors are inspired by catppuccin palettes (https://github.com/catppuccin/catppuccin)
####################################################################################################

# COLORS

# background for frappe catppuccin terminal theme
# thm_bg="#303446"

# background for macchiato catppuccin terminal theme
thm_bg="#24273A"

thm_fg="#c6d0f5"
thm_cyan="#99d1db"
thm_black="#292c3c"
thm_gray="#414559"
thm_magenta="#ca9ee6"
thm_pink="#f4b8e4"
thm_blue="#8caaee"
thm_black4="#626880"
rosewater="#f2d5cf"
flamingo="#eebebe"
pink="#f4b8e4"
mauve="#ca9ee6"
red="#e78284"
maroon="#ea999c"
peach="#ef9f76"
yellow="#e5c890"
green="#a6d189"
teal="#81c8be"
sky="#99d1db"
sapphire="#85c1dc"
blue="#8caaee"
lavender="#babbf1"
text="#c6d0f5"
subtext1="#b5bfe2"
subtext0="#a5adce"
overlay2="#949cbb"
overlay1="#838ba7"
overlay0="#737994"
surface2="#626880"
surface1="#51576d"
surface0="#414559"
base="#303446"
mantle="#292c3c"
crust="#232634"
eggplant="#e889d2"
sky_blue="#a7c7e7"
spotify_green="#1db954"
spotify_black="#191414"

TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""
TMUX_POWERLINE_SEPARATOR_THIN="|"

# See Color formatting section below for details on what colors can be used here.
TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-$thm_bg}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-$thm_fg}
TMUX_POWERLINE_SEG_AIR_COLOR=$(tp_air_color)

TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}

# See `man tmux` for additional formatting options for the status line.
# The `format regular` and `format inverse` functions are provided as conveinences

# shellcheck disable=SC2128
if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_CURRENT" ]; then
	TMUX_POWERLINE_WINDOW_STATUS_CURRENT=(
		"#[$(tp_format regular)]"
		"$TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR"
		"#[$(tp_format inverse)]"
		" #I#F "
		"$TMUX_POWERLINE_SEPARATOR_THIN"
		" #W "
		"#[$(tp_format regular)]"
		"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR"
	)
fi

# shellcheck disable=SC2128
if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_STYLE" ]; then
	TMUX_POWERLINE_WINDOW_STATUS_STYLE=(
		"$(tp_format regular)"
	)
fi

# shellcheck disable=SC2128
if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_FORMAT" ]; then
	TMUX_POWERLINE_WINDOW_STATUS_FORMAT=(
		"#[$(tp_format regular)]"
		"  #I#{?window_flags,#F, } "
		"$TMUX_POWERLINE_SEPARATOR_THIN"
		" #W "
	)
fi

# Format: segment_name [background_color|default_bg_color] [foreground_color|default_fg_color] [non_default_separator|default_separator] [separator_background_color|no_sep_bg_color]
#                      [separator_foreground_color|no_sep_fg_color] [spacing_disable|no_spacing_disable] [separator_disable|no_separator_disable]
#
# * background_color and foreground_color. Color formatting (see `man tmux` for complete list):
#   * Named colors, e.g. black, red, green, yellow, blue, magenta, cyan, white
#   * Hexadecimal RGB string e.g. #ffffff
#   * 'default_fg_color|default_bg_color' for the default theme bg and fg color
#   * 'default' for the default tmux color.
#   * 'terminal' for the terminal's default background/foreground color
#   * The numbers 0-255 for the 256-color palette. Run `tmux-powerline/color-palette.sh` to see the colors.

# * non_default_separator - specify an alternative character for this segment's separator
#   * 'default_separator' for the theme default separator

# * separator_background_color - specify a unique background color for the separator
#   * 'no_sep_bg_color' for using the default coloring for the separator

# * separator_foreground_color - specify a unique foreground color for the separator
#   * 'no_sep_fg_color' for using the default coloring for the separator

# * spacing_disable - remove space on left, right or both sides of the segment:
#   * "no_spacing_disable" - don't disable spacing (default)
#   * "left_disable" - disable space on the left
#   * "right_disable" - disable space on the right
#   * "both_disable" - disable spaces on both sides
#
# * separator_disable - disables drawing a separator on this segment, very useful for segments
#   with dynamic background colours (eg tmux_mem_cpu_load):
#   * "no_separator_disable" - don't disable the separator (default)
#   * "separator_disable" - disables the separator
#
# Example segment with separator disabled and right space character disabled:
# "hostname 33 0 {TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} 0 0 right_disable separator_disable"
#
# Example segment with spacing characters disabled on both sides but not touching the default coloring:
# "hostname 33 0 {TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} no_sep_bg_color no_sep_fg_color both_disable"
#
# Example segment with changing the foreground color of the default separator:
# "hostname 33 0 default_separator no_sep_bg_color 120"
#
## Note that although redundant the non_default_separator, separator_background_color and
# separator_foreground_color options must still be specified so that appropriate index
# of options to support the spacing_disable and separator_disable features can be used.
# The default_* and no_* can be used to keep the default behaviour.

# shellcheck disable=SC1143,SC2128
if [ -z "$TMUX_POWERLINE_LEFT_STATUS_SEGMENTS" ]; then
	TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
		"tmux_session_info $blue $thm_bg ${TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} no_sep_bg_color no_sep_fg_color right_disable"
		"hostname $eggplant $thm_bg ${TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} no_sep_bg_color no_sep_fg_color right_disable"
		"macos_notification_count 29 255"
		"mode_indicator 165 0 ${TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} no_sep_bg_color no_sep_fg_color right_disable"
		#"ifstat 30 255"
		"lan_ip $sky_blue $thm_bg ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN} no_sep_bg_color no_sep_fg_color right_disable"
		"wan_ip $sky_blue $thm_bg ${TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} no_sep_bg_color no_sep_fg_color right_disable"
		"ifstat_sys 30 255 ${TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} no_sep_bg_color no_sep_fg_color right_disable"
		"vcs_branch $thm_gray ${TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} no_sep_fg_color right_disable"
		#"air ${TMUX_POWERLINE_SEG_AIR_COLOR} $thm_bg"
		"vcs_compare 60 255 ${TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} no_sep_bg_color no_sep_fg_color right_disable"
		"vcs_staged 64 255 ${TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} no_sep_bg_color no_sep_fg_color right_disable"
		"vcs_modified 9 255 ${TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} no_sep_bg_color no_sep_fg_color right_disable"
		"vcs_others 245 0 ${TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} no_sep_bg_color no_sep_fg_color right_disable"
	)
fi

# shellcheck disable=SC1143,SC2128
if [ -z "$TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS" ]; then
	TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
		# "earthquake 3 0"
		"pwd $mauve $surface0"
		#"mailcount 9 255"
		"now_playing 234 37 ${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD} no_sep_bg_color no_sep_fg_color left_disable"
		#"cpu 240 136"
		#"load 237 167"
		#"tmux_mem_cpu_load 234 136"

		"$(
			if (($(tp_cpu_temp_at_least 65))); then
				echo "cpu_temp #ff2020 235 ${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD} no_sep_bg_color no_sep_fg_color left_disable"
			else
				echo "cpu_temp #303080 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD} no_sep_bg_color no_sep_fg_color left_disable"
			fi
		)"
	    "$(
	      if (($(tp_mem_used_percentage_at_least 90))); then
	        echo "mem_used #ff2020 235 ${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD} no_sep_bg_color no_sep_fg_color left_disable"
	      elif (($(tp_mem_used_percentage_at_least 75))); then
	      	echo "mem_used 136 235 ${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD} no_sep_bg_color no_sep_fg_color left_disable"
	      else
				echo "mem_used 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD} no_sep_bg_color no_sep_fg_color left_disable"
	      fi
	    )"

		#"battery $blue $thm_bg"
		"weather 37 255 ${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD} no_sep_bg_color no_sep_fg_color left_disable"
		#"rainbarf 0 ${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR}"
		#"xkb_layout 125 117"
		"date_day $teal $thm_bg ${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD} no_sep_bg_color no_sep_fg_color left_disable"
		"date $teal $thm_bg ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN} no_sep_bg_color no_sep_fg_color left_disable"
		"time $teal $thm_bg ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN} no_sep_bg_color no_sep_fg_color left_disable"
		#"utc_time 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN} no_sep_bg_color no_sep_fg_color left_disable"
	)
fi

