chmod +x ./auto_start.sh    # 这条是放松心情。
echo "若要启动本地Tomcat和所有container，请调用start函数执行。"
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

case "$1" in 
"status")
status
;;
"start")
start
;;
*)
usage
;;
esac