class_name ScriptCounter extends Object

static func count_recursive(path: String, deep: int = 8, typeHint: String = "") -> int:
	var directory := Directory.new()
	directory.open(path)
	
	var err = directory.list_dir_begin(true) # remove the navigational folders (. & ..)
	
	if err != OK: return -1
	# else
	
	var count := 0
	
	var fileName := directory.get_next()
	
	while(fileName):
		if directory.current_is_dir() && deep > 0:
			directory.get_current_dir()
			var resultCount: int = count_recursive("%s/%s" % [path, fileName], deep - 1)
			count += resultCount
		elif fileName.ends_with(".gd"):
			count += 1

		fileName = directory.get_next()
	
	return count
