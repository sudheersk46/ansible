if [ -f '/home/ec2-user/sudheer/ansible/testout.txt' ];then
rm  /home/ec2-user/sudheer/ansible/testout.txt
else
touch  /home/ec2-user/sudheer/ansible/testout.txt
fi
echo -e "\nDate and Time\n" >> /home/ec2-user/sudheer/ansible/testout.txt
uu=$(date +"%F %T")
echo $uu >> /home/ec2-user/sudheer/ansible/testout.txt 
echo -e "\nCluster Info\n" >> /home/ec2-user/sudheer/ansible/testout.txt 
kubectl cluster-info | grep Kubernetes >> /home/ec2-user/sudheer/ansible/testout.txt
kubectl cluster-info | grep Core >> /home/ec2-user/sudheer/ansible/testout.txt
#echo -e "\nCluster Info\n" >> /home/ec2-user/sudheer/ansible/testout.txt
#kubectl describe node >> /home/ec2-user/sudheer/ansible/testout.txt
echo -e "\nNode Info\n" >> /home/ec2-user/sudheer/ansible/testout.txt
kubectl get nodes -o wide >> /home/ec2-user/sudheer/ansible/testout.txt
#echo -e "\nPods Info\n" >> /home/ec2-user/sudheer/ansible/testout.txt
#kubectl get pods >> /home/ec2-user/sudheer/ansible/testout.txt
echo -e "\nNamespace Info\n" >> /home/ec2-user/sudheer/ansible/testout.txt
kubectl get namespace >> /home/ec2-user/sudheer/ansible/testout.txt
echo -e "\n Info\n" >> /home/ec2-user/sudheer/ansible/testout.txt
kubectl get nodes -n demo >> /home/ec2-user/sudheer/ansible/testout.txt
echo -e "\nPods Info\n" >> /home/ec2-user/sudheer/ansible/testout.txt
kubectl get po -n demo >> /home/ec2-user/sudheer/ansible/testout.txt
echo -e "\nService Info\n" >> /home/ec2-user/sudheer/ansible/testout.txt
kubectl get svc -n demo >> /home/ec2-user/sudheer/ansible/testout.txt
echo -e "\nDeployment Info\n" >> /home/ec2-user/sudheer/ansible/testout.txt
kubectl get deployment  -n demo >> /home/ec2-user/sudheer/ansible/testout.txt
echo -e "\nComplete Info\n" >> /home/ec2-user/sudheer/ansible/testout.txt
kubectl describe node >> /home/ec2-user/sudheer/ansible/testout.txt

