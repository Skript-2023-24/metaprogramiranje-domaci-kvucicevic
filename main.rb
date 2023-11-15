require './table'

table1 = Table.new('primer.xlsx')

# prints table
p table1.print_table

# Moguće je pristupati redu preko t.row(1), i pristup njegovim elementima po sintaksi niza.
p 'row 1 is: '
p table1.get_row(3)

# Biblioteka treba da vodi računa o merge-ovanim poljima   What does this mean?

p 'kolone'
p table1.initialize_cols

# Biblioteka vraća celu kolonu kada se napravi upit t[“Prva Kolona”]
p 'ime'
# p table1.get_col_by_name('Prva kolona')
p table1['Prva kolona']
p table1['Prva kolona'][1]

# Biblioteka omogućava pristup vrednostima unutar kolone po sledećoj sintaksi t[“Prva  Kolona”][1]
#              za pristup drugom elementu te kolone
