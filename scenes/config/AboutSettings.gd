extends Control

const WEBSITE_URL := "https://github.com/retrohub-org/retrohub"
const ISSUES_URL := "https://github.com/retrohub-org/retrohub/issues"

onready var n_name := $"%Name"
onready var n_version := $"%Version"
onready var n_engine_version := $"%EngineVersion"
onready var n_gpl_text := $"%GPLText"
onready var n_licenses := $"%Licenses"
onready var n_licenses_names := $"%Names"

onready var n_libraries_intro_lbl := $"%LibrariesIntroLabel"
onready var n_assets_intro_lbl := $"%AssetsIntroLabel"

onready var n_tabs := $"%TabContainer"
onready var n_open_website_button := $"%OpenWebsiteButton"


func _ready():
	if not OS.has_feature("rh_gpl"):
		n_gpl_text.queue_free()
		$"%LicenseText".get_child(1).next = "../../../.."
	n_version.text = n_version.text % RetroHub.version_str
	n_engine_version.text = n_engine_version.text % Engine.get_version_info()["string"]

func grab_focus():
	if RetroHubConfig.config.accessibility_screen_reader_enabled:
		match n_tabs.current_tab:
			0: # About RetroHub
				n_name.grab_focus()
			1: # Libraries
				n_libraries_intro_lbl.grab_focus()
			2: # Assets
				n_assets_intro_lbl.grab_focus()
			3: # Licenses
				n_licenses_names.grab_focus()
	else:
		match n_tabs.current_tab:
			0: # About RetroHub
				n_open_website_button.grab_focus()
			3: # Licenses
				n_licenses_names.grab_focus()

func _on_RichTextLabel_meta_clicked(meta):
	if "http" in meta:
		#warning-ignore:return_value_discarded
		OS.shell_open(meta)
		return
	# License text
	if n_licenses.select_license(meta):
		n_tabs.current_tab = 3

func _on_OpenWebsiteButton_pressed():
	#warning-ignore:return_value_discarded
	OS.shell_open(WEBSITE_URL)


func _on_OpenIssuesButton_pressed():
	#warning-ignore:return_value_discarded
	OS.shell_open(ISSUES_URL)


func _on_TabContainerHandler_tab_changed(_tab_container, enter_tab):
	if enter_tab:
		grab_focus()

