import numpy as np
import pandas as pd

# read the dataset as a DataFrame into a variable named 'prod'
path = 'C:/Users/cody.ringrissler/Source/eda-with-pandas/02-pandas-i/data/Production.Product.csv'
sep =	'\t'
i_col = "ProductID"
prod = pd.read_csv(path,sep, index_col = i_col)
prod.set_index('ProductID',inplace= True)

# basic DataFrame operations
prod.head()
prod.tail()
prod.shape #returnes tuple of (RowCount,ColumCount) prod.shape[0]
prod.columns
prod.Index
prod.describe()
prod.notnull()
prod.isnull()
prod.isnull().sum()
prod['col'].nunique()
prod['col'].unique()
prod['col'].hist(grid = False, bins = 5)

#group by 
prod.groupby(['col']).count()


#Group by multiple aggreggate function.
grouped = chip.groupby('item_name')
menu_price = grouped.agg({
            'item_price':'mean', #the Choice descritption affects this. Chicken bowl $8.75 W/ guac $11.25
            'quantity': 'sum', #sum the quantity of times ordered
            'order_id': 'nunique' #Count unique orders
}).sort_values(['quantity'], ascending = False)
menu_price.head(20)



#rename column
prod.rename(columns = {'Name' : 'Product_Name','ProductNumber':'Number'} , inplace= True)

#select from dataframe
prod['Color']
prod['Color'].head()
prod[['Color','ListPrice']]

prod['Color'].head(15) == 'Black'
prod[prod['Color'] == 'Black']
prod.select_dtypes(exclude = 'number')



# filtering
df['col1'] == 'Condition'
df[ (CONDITION 1) & (CONDITION 2) ]
df[ (CONDITION 1) | (CONDITION 2) ]a
df[ df['col1'] < 50 ] # filter column to be less than 50
df[ (df['col1'] == value1) & (df['col2'] > value2) ] # filter column where col1 is equal to value1 AND col2 is greater to value 2

# sorting
df.sort_values(by='column_name', ascending = False) # sort biggest to smallest



#Good count of nulls notnull()
null_df = pd.DataFrame(prod.isnull().sum() , columns= ['count of nulls'])
null_df.index.name = 'Column'
null_df.sort_values(['count of nulls'],ascending = False)

#replace values
movies['content_rating'].replace(to_replace =
                                     {
                                      'NOT RATED' : 'UNRATED', 
                                      'APPROVED' : 'UNRATED', 
                                      'PASSED' : 'UNRATED',
                                      'X': 'NC-17',
                                      'TV-MA' : 'NC-17'
                                     }, 
                                 inplace =False)


#Create from Text
raw_data = {"Column_One": ['Record', 'Record','Record','Record'],
            "Column_Two": [0,1,2,3]                       
            }
Data = pd.DataFrame(raw_data)
Data = pd.DataFrame(raw_data, columns = ['Column_Two','Column_One'])


#add Column
Data['Coumn_Three'] = ['Record', 'Record','Record','Record']
Data['Coumn_Four'] = [1,2,3,4]


#Reorder columns
Data = Data[['Coumn_Four', 'Coumn_Three', 'Column_Two','Column_One']]








chipo['occupation'] #select occupation from user
chipo['occupation'].nunique() #select distinct occupation from user
chipo.occupation.value_counts().head() #select occupation,count(*) from chipo group by occupation
chipo.sort_values(by = "item_name") #select * from chipo sort by item_name

chipo.describe() #basic statistics for only numeric columns
chipo.describe(include = "all") #all Columns
chipo.occupation.describe() #Describe a selected columns
chipo.age.mean() #mean of a column


chipo.age.value_counts().tail()




url = "https://raw.githubusercontent.com/justmarkham/DAT8/master/data/chipotle.tsv"
sep = "\t"
chipo = pd.read_csv(url,sep)

#Drop $ from item_price, not exactly sure how??
prices = [float(value[1 : -1]) for value in chipo.item_price] 

#Reassign cleaned values
chipo.item_price = prices

# delete the duplicates in item_name and quantity create new DF of 
chipo_filtered = chipo.drop_duplicates(['item_name','quantity'])

# select only the products with quantity equals to 1
chipo_one_prod = chipo_filtered[chipo_filtered.quantity == 1]

chipo_one_prod[chipo_one_prod['item_price']>10].item_name.nunique()

#select count(*)
chipo_drink_steak_bowl = chipo[(chipo.item_name == "Canned Soda") & (chipo.quantity > 1)]
len(chipo_drink_steak_bowl)