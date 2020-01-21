#!/usr/bin/env bash
SelfPath() { echo "$(__Join "$(SelfParent)" "$(SelfName)")"; }
SelfParent() { echo "$(__Parent "${BASH_SOURCE:-0}")"; }
SelfName() { echo "$(__Name "${BASH_SOURCE:-0}")"; }
SelfExt() { echo "$(__Ext "${BASH_SOURCE:-0}")"; }
SelfNameId() { echo "$(__NameId "${BASH_SOURCE:-0}")"; } # WithoutExt
CallerPath() { echo "$(__Join "$(CallerParent)" "$(CallerName)")"; }
CallerParent() { echo "$(__Parent "$0")"; }
CallerName() { echo "$(__Name "$0")"; }
CallerExt() { echo "$(__Ext "$0")"; }
CallerNameId() { echo "$(__NameId "$0")"; } # WithoutExt
__Join() { args=("$@"); echo "$(IFS="${args[0]}"; echo "${args[*]:1:${#args[@]}}")"; }
__Parent() { echo "$(cd "$(dirname "$1")"; pwd)"; }
__Name() { echo "$(basename "$1")"; }
__Ext() { local n="$(__Name $1)"; echo "${n##*.}"; }
__NameId() { local n="$(__Name $1)"; echo "${n%.*}"; }
__Import() {
	ListupFunctions() {
		for file in "$@"; do (
			env -i bash -c ". "$file"; "'echo "$(declare -F -p | cut -d " " -f 3)";'
		) done
	}
	RenameFunction() { # $1:old_func_name, $2:new_func_name
		declare -F "$1" > /dev/null || return 1
		eval "$(echo "${2}()"; declare -f ${1} | tail -n +2)"
		unset -f "$1"
	}
	PrefixedName() { # $1: a/b/c/d.sh, $2:func => a.b.c.d.func   $1:'', $2: func => func
		local SEP='/'; local DOT='.'; 
		local dir_names="$1"
		local filename=$(__NameId "$1")
		local funcname="$2"
		[[ "$1" = *\.sh ]] && dir_names="$(dirname "$1")"
		[ '.' = "$dir_names" ] && dir_names=''
		dir_names="${dir_names//$SEP/$DOT}"
		[ -n "$dir_names" ] && dir_names+=$DOT
		[ -n "$filename" ] && filename+=$DOT
		echo "$dir_names$filename$funcname"
	}
	for file in "$@"; do {
		funcs="$(ListupFunctions "$file")"
		. "$(__Join '/' "$(CallerParent)" "$file")"
		for func in $(echo -e "$funcs"); do
			RenameFunction "$func" "$(PrefixedName "$file" "$func")"
		done
	} done;
}
__Import "$@"
