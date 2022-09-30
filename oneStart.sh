chmod +x ${BASH_SOURCE}    # 这条是放松心情。

# echo "若要启动本地Tomcat和所有container，请调用start函数执行。"
# 参数说明文档
helps(){
    clear
    echo "操作指令："
    echo "${BASH_SOURCE} [options]"

    echo "[options]说明："
    echo "-all           一键安装：python、pip、docker-compose、vulnhub"
    echo "-update        升级：centos系统升级"
    echo "-python3       一键安装：python3，以及最新PIP3"
    echo "-pip,-pip3     一键安装：最新pip"
    echo "-start         一键启动：本地docker所有容器，自行配置Tomcat路径后可同时启动Tomcat"
    echo "-compose       一键安装：pip安装docker-compose"
    echo "-vulnhub       一键安装：vulnhub靶场"
}


all(){
    # update
    python
    pip
    compose
    vulhub
    # 展示
    uname -a
    python -v
    python3 -v
    docker-compose --version
}

update(){
    yum update -y  # 更新系统所有package
    clear
    echo "您的系统已经是最新版本"
}

python(){
    echo "安装python3....."
    yum install python3 -y
    clear
    echo "已安装最新python3，无需任何处理。"
    # python3 --version     # 这条命令不要放开，会进入死循环，查python2就不会，因为python3里的__init__有个循环，暂时不知道怎么搞。
}

pip(){
    # python3
    python3 -m pip install --upgrade pip 2>/dev/null
    pip3 install --upgrade pip
    clear
    echo "已安装最新pip，无需任何处理："
    echo "`pip3 -V`"
}

compose(){
    # pip
    pip3 install docker-compose
    clear
    echo "docker-compose 已安装"
    # version="echo `docker-compose version`"
}

vulnhub(){
    yum -y install git
    clone="`git clone https://github.com/vulhub/vulhub.git`"
    # git clone https://github.com/vulhub/vulhub.git
    clear
    echo "vulnhub 已安装"
}

start(){
    # 启动Tomcat
    echo "本shell内包含了Tomcat、docker_container。"
    # tomcat=""
    # $tomcat/startup.sh
    echo "Tomcat未启动，请自行添加Tomcat地址后再次执行。"

    echo "启动container："
    # docker容器操作
    echo "您目前已存在的container信息："
    docker ps -a
    # step-1：获取容器ID
    ID="`docker ps -aq`"

    count="`docker ps -aq | wc -l`"
    arr_ID=()
    for id in $ID;do
        # step-2：ID进入数组
        for i in $count;do
            arr_ID[i]=$id;
            echo "${arr_ID[i]}"
        done;
        # echo "======================================="
        # for i in $ID;do
        #     arr_ID[i]=$id;
        #     echo "======================================="
        #     echo "${arr_ID[i]}"
        # done;

        #启动容器
        for start_ID in ${arr_ID[*]};do
            docker restart $start_ID
            echo "正在启动ID:$start_ID"
        done;

        # 停止容器
        # for start_ID in ${arr_ID[*]};do
        #     docker stop $start_ID
        #     echo "正在停止ID:$start_ID"
        # done;
    
    done;

    docker ps -a
}

status(){
    ID(){
        echo "ID遍历测试"
        IDS="`docker ps -aq`"
        for id in $IDS;do
            docker stats $id
        done;
    }
}

# 指令集成
case "$1" in 
"-status") status
;;
"-start") start
;;
"-help") helps
;;
"-h") helps
;;
"") helps
;;
"-all") all
;;
"-update") update
;;
"-python3") python
;;
"-pip") pip
;;
"-pip3") pip
;;
"-compose") compose
;;
"-vulnhub") vulnhub
;;

*)
# usage
# ;;
esac
