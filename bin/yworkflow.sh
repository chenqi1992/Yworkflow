#!/bin/bash
# Yworkflow 项目启动器
# Author:luolei

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/root/bin

clear

export PATH="/usr/local/bin:$PATH"
 export NODE_PATH=/usr/local/lib/node_modules
source /usr/local/opt/nvm/nvm.sh

# 获得Yworkflow3的执行路径
ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
ABS_PARENT_ROOT="$(dirname "$ABSOLUTE_PATH")"
APP_ROOT="$(dirname "$ABS_PARENT_ROOT")"

yworkHistoryConf=$HOME/.yworkhistory
> $yworkHistoryConf
projectList=$APP_ROOT/.yworkprojects

if [ ! -e "$projectList" ]; then
	echo '自动创建项目路径文件'
    echo "" >> $projectList 
else
	echo ''
fi

Num=1
function main(){
    echo "Hello,请选择要通过Yworkflow启动的项目:"
    echo "======================================================"
    cat $projectList | grep -v "^$" | while read path
    
    do
     echo "$Num---$path" >> $yworkHistoryConf;
     Num=$(($Num+1))
    done

    cat $yworkHistoryConf
    echo "======================================================"
    read -p "请输入项目编号(1/2/3...):" proNum
    proConfPath=`cat $yworkHistoryConf | grep "^$proNum---" | awk -F':' '{print $2}'`
    echo $proConfPath
    cd $APP_ROOT && gulp dev --path $proConfPath
}
main