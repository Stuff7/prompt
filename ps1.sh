function set_prompt {
  # Icons
  local iSep=""
  local iGh=""
  local iTime="󰥔"
  local iUser=""
  local iHome=""
  local iStart=""
  local iCaret="$"
  local iEdit="󰷭"
  local iCheck=""

  # Colors
  local ESC='\033'

  local cTimeBg="${ESC}[48;2;0;118;193m"
  local cTimeFg="${ESC}[38;2;0;118;193m"

  local cUserBg="${ESC}[48;2;255;146;72m"
  local cUserFg="${ESC}[38;2;255;146;72m"

  local cDirBg="${ESC}[48;2;69;133;136m"
  local cDirFg="${ESC}[38;2;69;133;136m"

  local cCaretBg="${ESC}[48;2;100;200;70m"
  local cCaretFg="${ESC}[38;2;100;200;70m"

  local whiteFg="${ESC}[38;2;255;255;255m"
  local blackFg="${ESC}[38;2;45;52;54m"

  local bold="${ESC}[1m"
  local reset="${ESC}[0m"

  local time=$(date +"%r")
  local gitBranch=""
  local gitChanges=""
  local gitStatus=""
  if [ -d .git ]; then
    gitBranch=" $iGh $(git rev-parse --abbrev-ref HEAD) "
    gitChanges=$(git status --porcelain)
    if [ -n "$gitChanges" ]; then
      gitStatus="$iEdit"
    else
      gitStatus="$iCheck"
    fi
    gitChanges=$(if [ -n "$gitChanges" ]; then echo "  ~$(echo "$gitChanges" | wc -l)"; else echo ""; fi)
    local cBranchBg="${ESC}[48;2;255;235;149m"
    local cBranchFg="${ESC}[38;2;255;235;149m"
  fi
  local currDir=$(pwd | sed "s|$HOME|~|g")

  local bTime="${bold}${cTimeFg}${iStart}${whiteFg}${cTimeBg} ${iTime} ${time} ${cUserBg}${cTimeFg}${iSep}"
  local bUser="${blackFg}${cUserBg} ${iUser} ${USER} ${cDirBg}${cUserFg}${iSep}"
  local bDir="${cDirBg}${whiteFg} ${iHome} ${currDir} ${reset}${cBranchBg}${cDirFg}${iSep}"
  local bBranch=$(if [ -n "$gitBranch" ]; then echo "${cBranchBg}${blackFg}${gitBranch}${gitStatus}${gitChanges} ${reset}${cBranchFg}${iSep}"; else echo ""; fi)
  local caret="${reset}${bold}${cCaretFg}${iCaret} ${reset}"

  PS1="${bTime}${bUser}${bDir}${bBranch}\n ${caret}"
}

PROMPT_COMMAND="set_prompt"
