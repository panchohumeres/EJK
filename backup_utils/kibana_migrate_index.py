
# coding: utf-8

# In[1]:


# SCRIPT PARA CAMBIAR ELEMENTOS DE KIBANA (VISUALIZACIONES Y DASHBOARDS) DE UN INDICE A OTRO
#python 2.7


# In[2]:


import json


# In[3]:


filename='export_ckan(7).ndjson' #ruta o nombre archivo origen (exportado de kibana)


# In[4]:


suffix='junar' #sufijo para nuevo archivo
filename_out='export_'+suffix+'.ndjson'


# In[5]:


#importar los elementos de kibana como json separados (vienen unidos, uno por linea en el .njson)
#data=[]
#with open(filename) as f:
#    for line in f:
#        data.append(json.loads(line))


# In[7]:


#importar elementos de kibana como string
with open(filename, 'r') as file:
    string = file.read()


# In[26]:


dictionary={ #diccionario para reemplazar terminos

'69228140-16ed-11e9-8937-a3fdf9a88996':'edd713a0-b17b-11e9-8d71-81c145e2fabe', #id index origen para reemplazar,  #id index destino (nuevo)

'ckan':'junar', #nombre de antiguo index pattern #nombre de nuevo index pattern
#extras (labels etc)
    'datasets':'Recursos',
    'Datasets':'Recursos',
    'CKAN':'Junar'


}


# In[27]:


#subsituir strings
new_string=string
for key in dictionary.iterkeys():
    new_string=new_string.replace(key, dictionary[key])



# In[28]:


#exportar nuevos elementos de kibana como string
with open(filename_out, "w") as text_file:
    text_file.write(new_string)

