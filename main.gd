extends Control

var cmd_command : String
var windows : String = "10"

var edition : String = "Pro"
var edition_int : int = -1

#Dont change order
var windows_8_1 = ["Home", "Home N", "Home Single Language", "Professional", "Professional N", "Professional WMC", "Enterprice", "Enterprice N"]
var windows_8 = ["Home", "Home Single Language", "Professional", "Professional N", "Professional WMC", "Enterprice", "Enterprice N"]
var windows_10 = ["Home", "Home N", "Home Single Language", "Home Country Specific", "Professional", "Professional N", "Education", "Education N", "Enterprice", "Enterprice N"]
var windows_11 = ["Home", "Home N", "Home Single Language", "Home Country Specific", "Professional", "Professional N", "Education", "Education N", "Enterprice", "Enterprice N"]
#Dont change order
var windows_8_keys = ["BN3D2-R7TKB-3YPBD-8DRP2-27GG4","2WN2H-YGCQR-KFX6K-CD6TF-84YXQ","NG4HW-VH26C-733KW-K6F98-J8CK4","XCVCF-2NXM9-723PB-MHCB7-2RYQQ","GNBB8-YVD74-QJHX6-27H4K-8QHDG","32JNW-9KQ84-P47T8-D8GGY-CWCK7","JMNMF-RHW7P-DMY6X-RF3DR-X2BQT"]
var windows_8_1_keys = ["M9Q9P-WNJJT-6PXPY-DWX8H-6XWKK","7B9N3-D94CG-YTVHR-QBPX3-RJP64","BB6NG-PQ82V-VRDPW-8XVD2-V8P66","GCRJD-8NW9H-F2CDX-CCM8D-9D6T9","HMCNV-VVBFX-7HMBH-CTY9B-B4FXY","789NJ-TQK6T-6XTH8-J39CJ-J8D3P","MHF9N-XY6XB-WVXMC-BTDCT-MKKG7","TT4HM-HN7YT-62K67-RGRQJ-JFFXW"]
var windows_10_keys = ["TX9XD-98N7V-6WMQ6-BX7FG-H8Q99","3KHY7-WNT83-DGQKR-F7HPR-844BM","7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH","PVMJN-6DFY6-9CCP6-7BKTT-D3WVR","W269N-WFGWX-YVC9B-4J6C9-T83GX","MH37W-N47XK-V7XM9-C7227-GCQG9","NW6C2-QMPVW-D7KKK-3GKT6-VCFB2","NPPR9-FWDCX-D2C8J-H872K-2YT43","DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4"]
var windows_11_keys = ["TX9XD-98N7V-6WMQ6-BX7FG-H8Q99","3KHY7-WNT83-DGQKR-F7HPR-844BM","7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH","PVMJN-6DFY6-9CCP6-7BKTT-D3WVR","W269N-WFGWX-YVC9B-4J6C9-T83GX","MH37W-N47XK-V7XM9-C7227-GCQG9","NW6C2-QMPVW-D7KKK-3GKT6-VCFB2","NPPR9-FWDCX-D2C8J-H872K-2YT43","DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4"]

onready var tween = $logo/Tween
onready var logo = $logo

onready var key_enter = $input/key_enter
onready var activate_button = $input/activate_button
onready var winver = $input/winver
onready var win_mod = $input/win_mod

func _ready() -> void:
	update_list()
	tween.interpolate_property(logo,"modulate:a",logo.modulate.a,0,1,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	tween.start()

func update_list():
	win_mod.clear()
	if windows == "8_1":
		for i in windows_8_1:
			win_mod.add_item(i)
	if windows == "8":
		for i in windows_8:
			win_mod.add_item(i)
	if windows == "10":
		for i in windows_10:
			win_mod.add_item(i)
	if windows == "11":
		for i in windows_10:
			win_mod.add_item(i)

func set_key():
	if windows == "10":
		key_enter.text = windows_10_keys[edition_int]
	elif windows == "11":
		key_enter.text = windows_11_keys[edition_int]
	elif windows == "8_1":
		key_enter.text = windows_8_1_keys[edition_int]
	elif windows == "8":
		key_enter.text = windows_8_keys[edition_int]

func _on_open_key_list_pressed() -> void:
	print(OS.shell_open("https://docs.microsoft.com/ru-ru/windows-server/get-started/kms-client-activation-keys"))

func install_key():
	print(OS.execute(cmd_command,[]))

func KMS():
	print(OS.execute("slmgr",["/skms",""]))

func FinalActivate():
	print(OS.execute("slmgr",["/ato"]))

func _on_activate_button_pressed() -> void:
	if activate_button.text == "Are you sure?":
		
		if windows == "10":
			cmd_command = "slmgr /ipk " + windows_10_keys[edition_int]
		elif windows == "11":
			cmd_command = "slmgr /ipk " + windows_11_keys[edition_int]
		elif windows == "8_1":
			cmd_command = "slmgr /ipk " + windows_8_1_keys[edition_int]
		elif windows == "8":
			cmd_command = "slmgr /ipk " + windows_8_keys[edition_int]
		
		install_key()
		KMS()
		FinalActivate()
		activate_button.text = "Done"
		return 
	
	activate_button.text = "Are you sure?"

func _on_win_mod_item_selected(index: int) -> void:
	if windows == "8":
		edition = windows_8[index]
	elif windows == "8_1":
		edition = windows_8_1[index]
	elif windows == "10":
		edition = windows_10[index]
	elif windows == "11":
		edition = windows_11[index]
	edition_int = index
	set_key()

func _on_winver_item_selected(index: int) -> void:
	if index == 0:
		windows = "8"
	elif index == 1:
		windows = "8_1"
	elif index == 2:
		windows = "10"
	elif index == 3:
		windows = "11"
	set_key()
	update_list()
