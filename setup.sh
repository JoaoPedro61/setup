SDK_TOOL_LINIX_FILE_NAME="sdk-tools-linux-4333796.zip"
ANDROID_DIR="Android"
UNZIP_PATH=$(which unzip)
JAVA_PATH=$(which java)
NVM_LOCAL_DIR=~/.nvm
NODE_NVM_PATH=$(which node)
YARN_PATH=$(which yarn)
CURL_PATH=$(which curl)
WGET_PATH=$(which wget)
GRADLE_PATH=$(which gradle)
SOCAT_PATH=$(which socat)

# DEFINE VARS
echo "Variables: "
echo "-----------------------------------------------------"
echo -e "$SDK_TOOL_LINIX_FILE_NAME"
echo -e "$ANDROID_DIR"
echo -e "$UNZIP_PATH"
echo -e "$JAVA_PATH"
echo -e "$NVM_LOCAL_DIR"
echo -e "$NODE_NVM_PATH"
echo -e "$YARN_PATH"
echo -e "$CURL_PATH"
echo -e "$WGET_PATH"
echo -e "$GRADLE_PATH"
echo -e "$SOCAT_PATH"
echo "-----------------------------------------------------"
echo ""

# Go to working directory
cd

# Source .bashrc
source $HOME/.bashrc

# Utils functions
function ask {
  read -p "$1 $(if [ "$2" == "y" ]; then echo "(Y/n)"; else echo "(N/y)"; fi): " ASK_RESPONSE
  if [ -z "$ASK_RESPONSE" ]; then
    if [ "$2" == "y" ]; then
      return 1
    else
      return 0
    fi
  else
    if [ "$ASK_RESPONSE" == "Y" ] || [ "$ASK_RESPONSE" == "y" ]; then 
      return 1
    elif [ "$ASK_RESPONSE" == "n" ] || [ "$ASK_RESPONSE" == "N" ]; then
      return 0
    else
      return 3
    fi
  fi
  return 3
}

function install_npm_packages {
  source $HOME/.bashrc
  echo "Installing npm packages..."
  npm i -g typescript @angular/cli @angular/language-service expo-cli react-native
}

function execute_installation_of_platform_tools {
  echo "Trying install platform-tools..."
  if [ -d ~/$ANDROID_DIR/tools/bin ]; then
    cd ~/$ANDROID_DIR/tools/bin
    ./sdkmanager "platform-tools" "platforms;android-26" "build-tools;26.0.3"
  else
    echo "Can't find directory: ~/$ANDROID_DIR/tools/bin"
  fi
  # Go to Home
  cd
}

function configure_android_path {
  # Go to HOME
  cd
  export ANDROID_HOME=~/Android
  export PATH=$PATH:$ANDROID_HOME/tools
  export PATH=$PATH:$ANDROID_HOME/platform-tools
  printf "\n\n# Android Path Configuration\nexport ANDROID_HOME=~/Android\nexport PATH=\$PATH:\$ANDROID_HOME/tools\nexport PATH=\$PATH:\$ANDROID_HOME/platform-tools\n" >> $HOME/.bashrc
  source $HOME/.bashrc
}

function update_android_sdk {
  echo "Updating Android SDK"
  echo "Finding android binaries"
  if [ ! -z "$(which android)" ]; then
    echo "Binaries founded"
    echo "Running: android update sdk --no-ui"
    android update sdk --no-ui
  else
    echo "Android binary doens't exits"
  fi
}

function dowload_tools_android_and_unzip_it {
  echo "Dowloading $SDK_TOOL_LINIX_FILE_NAME"
  echo "Running: wget https://dl.google.com/android/repository/$SDK_TOOL_LINIX_FILE_NAME"
  wget https://dl.google.com/android/repository/$SDK_TOOL_LINIX_FILE_NAME
  echo "Unzipping..."
  if [ $1 -eq 1 ]; then
    echo "Using force override..."
    unzip -o sdk-tools-linux-4333796.zip -d ~/$ANDROID_DIR
  else
    unzip sdk-tools-linux-4333796.zip -d ~/$ANDROID_DIR
  fi
  echo -e "Removing \"$SDK_TOOL_LINIX_FILE_NAME\" file..."
  rm ~/$SDK_TOOL_LINIX_FILE_NAME
  execute_installation_of_platform_tools
  if [ ! $1 -eq 1 ]; then
    configure_android_path
    source $HOME/.bashrc
    update_android_sdk
  fi
}

function configure_java_path {
  echo "Finding Java Directory"
  JAVA_HOME=$(dirname $( readlink -f $(which java) ))
  JAVA_HOME=$(realpath "$JAVA_HOME"/../)
  export JAVA_HOME
  if [ ! -z "$JAVA_HOME" ]; then
    echo "Writting Java Path In Your .bashrc"
    printf "\n\n# Java path configuration\nJAVA_HOME=\$(dirname \$( readlink -f \$(which java) ))\nJAVA_HOME=\$(realpath "\$JAVA_HOME"/../)\nexport JAVA_HOME\nexport PATH=\$PATH:\$JAVA_HOME/bin\n" >> $HOME/.bashrc
    source $HOME/.bashrc
  else
    echo "Can 't Find Java Directory"
    exit 0;
  fi 
}

function install_wget {
  if [ -z "$WGET_PATH" ]; then
    ask "Install Wget?" "y"
    if [ $? -eq 1 ]; then 
      echo "Installing..."
      echo "Running: sudo apt update"
      sudo apt update
      echo "Running: sudo apt install wget"
      sudo apt install wget
    elif [ $? -eq 0 ]; then
      echo "To continue with the automated procedure, you need to install this dependency"
      exit 0;
    else
      echo "Option not available"
      exit 0;
    fi
  else
    echo -e "Wget Installed"
  fi
}

function install_curl {
  if [ -z "$CURL_PATH" ]; then
    ask "Install cUrl?" "y"
    if [ $? -eq 1 ]; then 
      echo "Installing..."
      echo "Running: sudo apt update"
      sudo apt update
      echo "Running: sudo apt install curl"
      sudo apt install curl
    elif [ $? -eq 0 ]; then
      echo "To continue with the automated procedure, you need to install this dependency"
      exit 0;
    else
      echo "Option not available"
      exit 0;
    fi
  else
    echo -e "cUrl Installed"
  fi
}

function install_nvm {
  source $HOME/.bashrc
  if [ -d $NVM_LOCAL_DIR ]; then
    echo "NVM Installed"
    if [ -z "$NODE_NVM_PATH" ]; then
      ask "Install Some Node Version?" "y"
      if [ $? -eq 1 ]; then 
        echo "Installing..."
        echo "Running: nvm install 12"
        nvm install 12
        echo "Running: nvm alias default 12"
        nvm alias default 12
        echo "Running: nvm use default"
        nvm use default
        install_npm_packages
      elif [ $? -eq 0 ]; then
        echo "To continue with the automated procedure, you need to install this dependency"
        exit 0;
      else
        echo "Option not available"
        exit 0;
      fi
    else
      echo -e "Some Node Version Is Installed"
    fi
  else
    ask "Install NVM?" "y"
    if [ $? -eq 1 ]; then 
      echo "Installing..."
      echo "Running: wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash"
      wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
      echo "Running: nvm install 12"
      nvm install 12
      echo "Running: nvm alias default 12"
      nvm alias default 12
      echo "Running: nvm use default"
      nvm use default
      install_npm_packages
    elif [ $? -eq 0 ]; then
      echo "To continue with the automated procedure, you need to install this dependency"
      exit 0;
    else
      echo "Option not available"
      exit 0;
    fi
  fi
}

function install_yarn {
  if [ -z "$YARN_PATH" ]; then
    ask "Install Yarn?" "y"
    if [ $? -eq 1 ]; then 
      echo "Installing..."
      echo "Running: curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -"
      curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
      echo "Running: echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list"
      echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
      echo "Running: sudo apt update"
      sudo apt update
      echo "Running: sudo apt install --no-install-recommends yarn"
      sudo apt install --no-install-recommends yarn
    elif [ $? -eq 0 ]; then
      echo "To continue with the automated procedure, you need to install this dependency"
      exit 0;
    else
      echo "Option not available"
      exit 0;
    fi
  else
    echo -e "Yarn Installed"
  fi
}

function install_unzip {
  if [ -z "$UNZIP_PATH" ]; then
    ask "Install Unzip?" "y"
    if [ $? -eq 1 ]; then 
      echo "Installing..."
      echo "Running: sudo apt-get install unzip"
      sudo apt-get install unzip
    elif [ $? -eq 0 ]; then
      echo "To continue with the automated procedure, you need to install this dependency"
      exit 0;
    else
      echo "Option not available"
      exit 0;
    fi
  else
    echo -e "Unzip Installed"
  fi
}

function install_java {
  if [ -z "$JAVA_PATH" ]; then
    ask "Install OpenJdk?" "y"
    if [ $? -eq 1 ]; then 
      echo "Installing..."
      echo "Running: sudo add-apt-repository ppa:openjdk-r/ppa"
      sudo add-apt-repository ppa:openjdk-r/ppa
      echo "Running: sudo apt-get update"
      sudo apt-get update
      echo "Running: sudo lib32z1 openjdk-8-jdk"
      sudo lib32z1 openjdk-8-jdk

      configure_java_path
    elif [ $? -eq 0 ]; then
      echo "To continue with the automated procedure, you need to install this dependency"
      exit 0;
    else
      echo "Option not available"
      exit 0;
    fi
  else
    echo -e "Java Installed"
    if [ -z "$JAVA_HOME" ]; then
      ask "Java is installed, but the path isn't configured, configure?" "y"
      if [ $? -eq 1 ]; then 
        configure_java_path
      elif [ $? -eq 0 ]; then
        echo "To continue with the automated procedure, you need to configure this dependency"
        exit 0;
      else
        echo "Option not available"
        exit 0;
      fi
    fi
  fi
}

function install_android {
  if [ -d ~/$ANDROID_DIR ]; then
    ask "Force Reinstall Android Command Line?" "n"
    if [ $? -eq 1 ]; then 
      dowload_tools_android_and_unzip_it 1
    else
      SHOULD_UPDATE_SDK=0
      if [ -z "$ANDROID_HOME" ]; then
        ask "Android is installed, but the path isn't configured, configure?" "y"
        if [ $? -eq 1 ]; then 
          configure_android_path
          SHOULD_UPDATE_SDK=1
        elif [ $? -eq 0 ]; then
          echo "To continue with the automated procedure, you need to configure this dependency"
          exit 0;
        else
          echo "Option not available"
          exit 0;
        fi
      fi

      ask "Force Reinstall Android Tools?" "n"
      if [ $? -eq 1 ]; then 
        execute_installation_of_platform_tools
        SHOULD_UPDATE_SDK=1
      fi

      if [ $SHOULD_UPDATE_SDK -eq 1 ]; then
        update_android_sdk
      else
        ask "Force Update Android SDK?" "n"
        if [ $? -eq 1 ]; then 
          update_android_sdk
        fi
      fi
    fi
  else
    dowload_tools_android_and_unzip_it 0
  fi
}

function install_socat {
  if [ -z "$SOCAT_PATH" ]; then
    ask "Install Socat?" "y"
    if [ $? -eq 1 ]; then 
      echo "Installing..."
      echo "Running: sudo apt-get update"
      sudo apt-get update
      echo "Running: sudo apt-get install socat"
      sudo apt-get install socat
    elif [ $? -eq 0 ]; then
      echo "To continue with the automated procedure, you need to install this dependency"
      exit 0;
    else
      echo "Option not available"
      exit 0;
    fi
  else
    echo -e "Socat Installed"
  fi
}

function configure_wsl_env {
  if [ -z "$WSL_HOST" ]; then
    ask "You are in WSL2 Environment?" "n"
    if [ $? -eq 1 ]; then
      echo "Configuring..."
      export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
      export ADB_SERVER_SOCKET=tcp:$WSL_HOST:5037
      socat -d -d TCP-LISTEN:5037,reuseaddr,fork TCP:$(cat /etc/resolv.conf | tail -n1 | cut -d " " -f 2):5037
      printf "\n\n# WSL2 Configuration\nexport WSL_HOST=\$(tail -1 /etc/resolv.conf | cut -d' ' -f2)\nexport ADB_SERVER_SOCKET=tcp:\$WSL_HOST:5037\nsocat -d -d TCP-LISTEN:5037,reuseaddr,fork TCP:\$(cat /etc/resolv.conf | tail -n1 | cut -d \" \" -f 2):5037\n" >> $HOME/.bashrc
      source $HOME/.bashrc
    fi
  fi
}

echo "Checking dependencies: "
echo "-----------------------------------------------------"
install_wget
install_curl
install_nvm
install_yarn
install_unzip
install_java
install_android
install_socat
configure_wsl_env
echo "-----------------------------------------------------"
echo ""
