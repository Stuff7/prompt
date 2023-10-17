# Icons

$iSep = [char]0xe0c0;
$iGh = [char]0xf09b;
$iTime = [char]0xf253;
$iUser = [char]0xf007;
$iHome = [char]0xf015;
$iStart = [char]0xe0b6;
$iCaret = [char]0xf054;
$iEdit = [char]0xf044;
$iCheck = [char]0xe63f;


# Colors

$ESC = [char]27;

$cTimeBg = "$ESC[48;2;0;118;193m";
$cTimeFg = "$ESC[38;2;0;118;193m";

$cUserBg = "$ESC[48;2;255;146;72m";
$cUserFg = "$ESC[38;2;255;146;72m";

$cDirBg = "$ESC[48;2;69;133;136m";
$cDirFg = "$ESC[38;2;69;133;136m";

$cCaretBg = "$ESC[48;2;100;200;70m";
$cCaretFg = "$ESC[38;2;100;200;70m";

$whiteFg = "$ESC[38;2;255;255;255m";
$blackFg = "$ESC[38;2;45;52;54m";

$bold = "$ESC[1m";
$reset = "$ESC[0m";

function prompt {
  $time = Get-Date -Format "hh:mm:ss tt";
  if (Test-Path .git) {
    $gitBranch = " $iGh $(git rev-parse --abbrev-ref HEAD) ";
    $gitChanges = git status --porcelain;
    $gitStatus = if ($gitChanges) {$iEdit} else {$iCheck};
    $gitChanges = if ($gitChanges) {"  ~$($($gitChanges -split "`n").Count)"} else {""};
    $cBranchBg = "$ESC[48;2;255;235;149m";
    $cBranchFg = "$ESC[38;2;255;235;149m";
  }
  $currDir = "$(Get-Location)".replace($env:PROJECTS, "");

  $bTime = "$bold$cTimeFg$iStart$whiteFg$cTimeBg $iTime $time $cUserBg$cTimeFg$iSep";
  $bUser = "$BlackFg$cUserBg $iUser $Env:username $cDirBg$cUserFg$iSep";
  $bDir = "$cDirBg$whiteFg $iHome $currDir $reset$cBranchBg$cDirFg$iSep";
  $bBranch = if ($gitBranch) {"$cBranchBg$blackFg$gitBranch$gitStatus$gitChanges $reset$cBranchFg$iSep"} else {""};
  $caret = "`n$reset$bold$cCaretFg$iCaret $reset";

  $bTime + $bUser + $bDir + $bBranch + $caret
}
