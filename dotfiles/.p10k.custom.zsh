# Example of a user-defined prompt segment. Function prompt_example will be called on every
# prompt if `example` prompt segment is added to POWERLEVEL9K_LEFT_PROMPT_ELEMENTS or
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS. It displays an icon and orange text greeting the user.
#
# Type `p10k help segment` for documentation and a more sophisticated example.
function prompt_ol_jh_gh () {

  # Only show in Graal directories
  if [[ $PWD != *"graal"* ]]; then
    return
  fi

  local jh=""
  local gh=""

  if [ ! -z $JAVA_HOME ] ; then
    if [ -f $JAVA_HOME/bin/java ]; then
      jh=$(eval "$JAVA_HOME/bin/java -version" 2>&1 | head -1 | cut -d'"' -f2 | sed '/^1\./s///' | cut -d'.' -f1;)
    else
      jh="?"
    fi
  fi

  if [ ! -z $GRAALVM_HOME ] ; then
    if [ -f $GRAALVM_HOME/bin/java ] ; then
      gh=$(eval "$GRAALVM_HOME/bin/java -version" 2>&1 | head -1 | cut -d'"' -f2 | sed '/^1\./s///' | cut -d'.' -f1;)
    else
      gh="?"
    fi
  fi

  if [ ! -z "$jh" ] && [ ! -z "$gh" ] ; then
    p10k segment -f 208 -i '' -t "j$jh g$gh"
  elif [ ! -z "$jh" ]; then
    p10k segment -f 208 -i '' -t "j$jh"
  elif [ ! -z "$gh" ]; then
    p10k segment -f 208 -i '' -t "g$gh"
  fi
}
