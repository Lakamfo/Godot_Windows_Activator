extends Control

var key : String
var winver : String = "Windows11n10"
var winmod : String = "Pro"

onready var key_enter = $input/key_enter
onready var activate_button = $input/activate_button

var keys = {
	"Windows7":{
		"Home":["YGFVB-QTFXQ-3H233-PTWTJ-YRYRV"],
		"Pro":["HYF8J-CVRMY-CM74G-RPHKF-PW487"]
	},
	"Windows8":{
		"Pro":["XKY4K-2NRWR-8F6P2-448RF-CRYQH"],
		"Home":["FB4WR-32NVD-4RW79-XQFWH-CYQG3"]
	},
	"Windows8_1":{
		"Home":["334NH-RXG76-64THK-C7CKG-D3VPT"],
		"Pro":["GCRJD-8NW9H-F2CDX-CCM8D-9D6T9"]
	},
	"Windows11n10":{
		"Home":
			["VK7JG-NPHTM-C97JM-9MPGT-3V66T",
			"22HC6-CFNCB-XP972-GF3KB-YWRDB","3H33N-VGBHC-T8CWX-QD8VP-KW3GY","78KFD-QV24B-HR6JM-8YKDK-36V8C","YGJRC-388H6-KH6FF-Q78K4-WJH44",
			"4F7MV-WMVHG-VVTKW-2Y34F-MCDW9","7YNRQ-R4VXM-J8MJP-7CQ7V-BDWVH","HFNYW-GFRG7-PQDYH-GJF3Y-X4R9M","QN4C6-GBJD2-FB422-GHWJK-GJG2R",
			"PTXN8-JFHJM-4WC78-MPCBR-9W4KR","6TP4R-GNPTD-KYYHQ-7B7DP-J447Y","2WH4N-8QGBV-H22JP-CT43Q-MDWWJ","N2434-X9D7W-8PF6X-8DV9T-8TYMD",
			"N87MP-V7R4F-C3FJV-BF8W6-683DV","FGBN9-9DMYX-FFRMJ-66X4B-YWQ97","H8P42-2HNY4-8VQKB-YY47K-RM47H","X4RBT-8YNCK-9RQFW-JTR32-Q3WVH"],
		"Pro":["KNJ4F-RP334-6X67G-7PGVQ-3PFDB","W269N-WFGWX-YVC9B-4J6C9-T83GX"]
	}
}

func _ready() -> void:
	randomize()

func _on_winver_item_selected(index: int) -> void:
	if index == 0:
		winver = "Windows7"
	if index == 1:
		winver = "Windows8"
	if index == 2:
		winver = "Windows8_1"
	if index == 3:
		winver = "Windows11n10"
	set_key()

func _on_win_mod_item_selected(index: int) -> void:
	if index == 0:
		winmod = "Pro"
	elif index == 1:
		winmod = "Home"
	set_key()

func set_key():

	if winver == "Windows11n10":
		if winmod == "Pro":
			key = keys.Windows11n10.Pro[randi() % keys.Windows11n10.Pro.size()]
		elif winmod == "Home":
			key = keys.Windows11n10.Home[randi() % keys.Windows11n10.Home.size()]
	elif winver == "Windows8_1":
		if winmod == "Pro":
			key = keys.Windows8_1.Pro[randi() % keys.Windows8_1.Pro.size()]
		elif winmod == "Home":
			key = keys.Windows8_1.Home[randi() % keys.Windows8_1.Home.size()]
	elif winver == "Windows8":
		if winmod == "Pro":
			key = keys.Windows8.Pro[randi() % keys.Windows8.Pro.size()]
		elif winmod == "Home":
			key = keys.Windows8.Home[randi() % keys.Windows8.Home.size()]
	elif winver == "Windows7":
		if winmod == "Pro":
			key = keys.Windows7.Pro[randi() % keys.Windows7.Pro.size()]
		elif winmod == "Home":
			key = keys.Windows7.Home[randi() % keys.Windows7.Home.size()]
	
	key_enter.text = key


func _on_open_key_list_pressed() -> void:
	print(OS.shell_open("https://docs.microsoft.com/ru-ru/windows-server/get-started/kms-client-activation-keys"))

func _on_activate_button_pressed() -> void:
	if activate_button.text == "Are you sure?":
		print(OS.execute("slmgr",["/ipk",key]))
		print(OS.execute("slmgr",["/skms","kms.xspace.in"]))
		print(OS.execute("slmgr",["/ato"]))
		activate_button.text = "Done"
		return
	activate_button.text = "Are you sure?"
