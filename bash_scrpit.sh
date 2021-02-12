
#!/bin/bash

addToRecord() # Adding a new Record
{
	echo
	while true #I made a while loop so the user can add as many records as he wants
	do
		echo "You can add new record full it empty places"
		echo "If you'd like to quit, enter 'q'."
		echo "Author="; read author #I'm taking user input via "read" and putting variables.
		echo "Title="; read title
		echo "Page="; read page
		echo "Year="; read year
		if [ "$author" == 'q' ] # if user press "q" program will close.
			then
			break
		fi
		echo
		echo 'author:' $author >> $title.txt #I set the title variable as the name of each newly created record file
		echo 'title:' $title >> $title.txt #Write the variables you get from the user to the file
		echo 'page:' $page >> $title.txt
		echo 'year:' $year >> $title.txt
		echo "The record added."
		echo
	done
}

displayRecord() #Showing records already exist.
{
	echo
	while true  #I made a while loop so the user can display as many records as he wants
	do
		echo "To display a record, enter the 'Author' and 'Title' (case sensitive)."
		echo "You must write 'Title' name exactly correct otherwise you will not see record." # Because i made "Title" as a record file name. If you write this wrong it will be impossinle the show inside of file.
		echo "If you'd like to quit, enter 'q'."
		echo "Author:"; read author #I'm taking user input via "read" and putting variables.
		echo "Title:"; read title
		if [ "$author" == 'q' ] # if user press "q" program will close.
			then
			break
		fi
		
		echo
		echo "Listing records for \"$author\" and \"$title\":"
		cat $title.txt |awk -v var="$author" -v var2="$title" '$0~var||$0~var2 {print "--> " $0}' 
										#Record file name same as Title so i'm getting title variable from user.
		RETURNSTATUS=`echo $?`			# Via pipe sending all text inside of file to the awk.
		if [ $RETURNSTATUS -eq 1 ]	    # I'm setting $author and $title variables in the awk via -v parameter.
			then						# var and var2 is two variable and so i must do search with variables. Because of that u must use that:"$0~var"
			echo "No records found."	# I have two variable so i must use "||" also. Otherwise second search will not work.
		fi   			# With "$?" i know lastest commannd has a correct output or not. if not i will showing error message.
		echo
	done
}


removeRecord() #Deleting record
{
	echo 
	while true #I made a while loop so the user can delete as many records as he wants
	do
		echo "To remove a record, enter the 'Title' (case sensitive)."
		echo "If you're done, enter 'q' to quit."
		read rInput
		if [ "$rInput" == 'q' ] # if user press "q" program will close.
			then
			break
		fi
		echo "Listing records for \"$rInput\":"
		cat $rInput.txt
		RETURNSTATUS=`echo $?` # With "$?" i know lastest commannd has a correct output or not. if not i will showing error message.
		if [ $RETURNSTATUS -eq 1 ]
			then
			echo "No records found for \"$rInput\""
			break
		else
			echo "Do you really want delete this record ?"
			echo "[yes] or [no] ? =" #I'm asking one more question for being sure.
			read status
			if [ "$status" == 'yes' ]
				then
				rm $rInput.txt
				echo
				echo "Record is Deleted !"
				echo
			fi
		fi
		echo
	done
}

echo "Hello, welcome to my bash script"
echo "Please enter one of the following letters:"
echo "a) Add a record"
echo "b) Show records"
echo "c) Delete record"
echo
read input

case $input in        # At the request of the user, I send the user to certain functions
	a) addToRecord;;
	b) displayRecord;;
	c) removeRecord;;
esac

echo
echo "Any changes you made have been saved."
echo