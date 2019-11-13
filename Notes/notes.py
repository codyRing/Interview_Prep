#on 5/21 Project 2 is due. Also need a developed idea for capstone project.

##List is a collection which is ordered and changeable. Allows duplicate members. []
x = [1, 2, 3]
x = ["Lord", "of", "the", "Rings"]

#list indexing and slicing
x[2] #Character at index 2 of x
x[i:j:k] #Slice of x from i to j with step k
x.append('string') #append 'string' to the very end
x.insert(2,'string') #insert string at index 2
x.remove('string') #remove the first occurrence of string
sorted(x) #sort x??


for x,y in enumerate(l):
    print(x,y)


##Tuple is a collection which is ordered and unchangeable. Allows duplicate members. An ordered sequence with a fixed number of elements ()
x = (1, 2, 3)
x = ("Kirk", "Picard", "Spock")





##Dictionary is a collection which is unordered, changeable and indexed. No duplicate members.{} cannot be sliced
x = {'Mark': 'Twain', 'Apples': 5}

##Set is a collection which is unordered and unindexed. No duplicate members.{}




##functions
#Rename a remote
##https://help.github.com/en/articles/renaming-a-remote
#git branch --set-upstream-to=cody/master
git remote add cody "https://git.generalassemb.ly/codyRing/Homework.git"

git push -u cody master


#codewars.com



List comprehension
total = sum(k for i in range(1, n+1))
sum(x +1 for x in range(10))
x= [4,4,4,4,4,4,4]
sum(i for i in x)


my_list = []
my_list_2 = []
my_list_3 = []
my_list = [1,6,2,70,4,1,3,4]
my_list_2 = sorted(my_list)
my_list.remove(my_list[4])
my_list_2.remove(my_list_2[4])
print(my_list)
print(my_list_2)

mylist = ["a", "b", "a", "c", "c"]
mylist = list(dict.fromkeys(mylist))
print(mylist)


my_list = []
my_list_reversed = []
my_list = [1,6,2,70,4,1,3,4]
my_list.pop(7)
my_list_reversed = list(reversed(my_list))
my_list.reverse()
print(my_list)
print(my_list_reversed)



def myfunction(var1):
    var2 = var1 + 2
    return var2

five_var = myfunction(3)

data['URL'].value_counts()[:n]
	
def is_leap(n):
	leap = False
	if n % 4 == 0:
		if n % 100 == 0:
			if n % 400 == 0:
				return True
			return False
		return True
	else:
		return False

	return leap
	
	
def calc_default_add(x, y, op="add"):
	if op == ('add'):
		return x + y
	elif op == ('sub'):
		return x - y		
	else:
		print ("Valid operations: add, sub")
		
		
		

	
	
	
class Band(object):
    def __init__(self, band, members, albums, sold, genre):
        self.members = members
        self.band = band
        self.albums = albums
        self.sold = sold
        self.genre = genre

    def print_stats(self):
        return 'band: {} members: {} albums: {} sold: {} genre: {}'.format(self.band, self.members, self.albums, self.sold, self.genre)

Queen = Band('Queen',4,15,105000000,'Rock')
print(Queen.print_stats())



import numpy as np

import pandas as pd

df = pd.DataFrame(np.array([[.25,"w",60], [-.9,"x",20], [.2,"y",700], [.6,"z",350]]), columns=["A","B","C"])

print (df)

df["C"] = df.C.astype('float64')
df.C.mean()   # Return the mean of column C.
df.mean()   # Return the mean of all numeric columns.

import pandas

#load file1.csv as a DataFrame and print the result to screen
data = pandas.read_csv("file1.csv")
print("data:")
print(data)

#get overall sense of data by getting numeric summary info of numeric columns using .describe()
print(data.describe())
print()

#get distribution of non-numeric columns using .value_counts() on col2 and col3
print(data.col2.value_counts())
print()

print(data.col3.value_counts())
print()

#get the mean of col1 grouped by col2
print("col1 mean grouped by col2:")
print(data.groupby("col2")["col1"].mean())
print()
#get the mean of col1 grouped by col3
print("col1 mean grouped by col3:")
print(data.groupby("col3")["col1"].mean())
print()

#pivot data into a new table where col2 is the index, col3's values are the individual columns, and the average value in col1 is the value in each cell
pivoted_data = pandas.pivot_table(data,values="col1",index=["col2"],columns=["col3"],aggfunc="mean",fill_value=0)
print(pivoted_data)

import pandas as pd
data =[12, 17, 19, 22, 30, 65]
df = pd.DataFrame(data)
print(df.describe())