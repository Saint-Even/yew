type="NS*"
tar="/home/holdens/holdensQNAP/outbox"

for i in ${type}
do 
	echo "copying ${i}" 
	cp -ra ${i} ${tar}
done; 

touch ${tar}/COMPLETE
