# vim: ft=zsh: ts=2: sts=2: expandtab
append_if_nz() {
  if [[ "$1" == "0" || "$1" == "" ]]; then
    echo -n ""
  else
    [ -z "$3" ] && echo -nE "${2}${1}" || echo -nE "$FG[${3}]${2}${1}%{$reset_color%}"
  fi
}

git_status() {
  local STATUS CURRENT_COMMIT BRANCH AHEAD BEHIND STAGED CONFLICT CHANGHED DELETED UNTRACKED

  STATUS="$(git --no-optional-locks status --porcelain=v2 --ignore-submodules --branch 2> /dev/null)"

  [ $? = 0 ] || return

  CURRENT_COMMIT=$(echo "$STATUS" | sed -En '/^# branch.oid/p' | sed -Ee 's/# branch.oid (([a-f0-9]{8}).*|\((initial)\))$/\2\3/g')
  BRANCH=$(echo "$STATUS" | awk '/^# branch.head/{print $3}')
  AHEAD=$(append_if_nz "$(echo "$STATUS" | sed -n '/^# branch.ab/p' | sed -Ee 's/^.*\+([0-9]+).*/\1/g')" "\u2191")
  BEHIND=$(append_if_nz "$(echo "$STATUS" | sed -n '/^# branch.ab/p' | sed -Ee 's/^.*-([0-9]+).*/\1/g')" "\u2193")
  STAGED=$(append_if_nz "$(echo "$STATUS" | sed -En '/^[0-9]+ (A|M|D). /p' | wc -l)" "+" "046") # green
  CONFLICT=$(append_if_nz "$(echo "$STATUS" | sed -En '/^u /p' | wc -l)" "!" "009") # red
  CHANGED=$(append_if_nz "$(echo "$STATUS" | sed -En '/^[0-9]+ .M /p' | wc -l)" "~" "081") # cyan
  RENAMED=$(append_if_nz "$(echo "$STATUS" | sed -En '/^[0-9]+ (R.|.R) /p' | wc -l)" "" "226") # YELLOW
  DELETED=$(append_if_nz "$(echo "$STATUS" | sed -En '/^[0-9]+ .D /p' | wc -l)" "×" "248") # gray
  UNTRACKED=$(if [ "$(echo "$STATUS" | sed -En '/^\? /p' | wc -l)" != "0" ] ; then echo "…"; fi) # ""; fi)

  [ "$BRANCH" == "(detached)" ] || [ "$CURRENT_COMMIT" == "initial" ] && BRANCH=":$CURRENT_COMMIT"

  RES="${AHEAD}${BEHIND}${STAGED}${CONFLICT}${CHANGED}${RENAMED}${DELETED}${UNTRACKED}"

  # Are we dirty?
  [ -z "$RES" ] && RES="$FG[118]${BRANCH}%{$reset_color%}" || RES="$FG[228]${BRANCH}%{$reset_color%}|${RES}"

  echo -ne "(${RES}) "
}

PROMPT='%(?..(%?%) )'
if [ -n "$SSH_CLIENT" ]; then
  PROMPT+="$FG[251][%{$reset_color%}$FG[081]%n%{$reset_color%}@$FG[092]%M%{$reset_color%}$FG[251]]%{$reset_color%} "
fi
PROMPT+='$FG[039]%c%{$reset_color%} $(git_status)%(!.#.$) '
