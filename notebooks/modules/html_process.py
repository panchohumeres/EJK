import re


class html_process:
    def __init__(self,df,**kwargs):
        self.df=df.copy()
        self.__dict__.update(**kwargs)
        
    def has_attribute(self,attribute):
        return (hasattr(self, attribute))        
            
    def remove_html_tags(self,text):
        #https://medium.com/@jorlugaqui/how-to-strip-html-tags-from-a-string-in-python-7cb81a2bbf44
        """Remove html tags from a string"""
        clean = re.compile('<.*?>')
        return re.sub(clean, '', text)
    
    def remove_line_break(self,df,regexes=((r'\\n',' '),(r'\n',' '))):
        for regex in regexes:
            df=df.replace(*regex, regex=True)
        
        return df
    
    def remove_html_tags_pattern(self):
        #https://stackoverflow.com/questions/44227748/removing-newlines-from-messy-strings-in-pandas-dataframe-cells
        df=self.df
        
        if self.has_attribute('fields'): #campos a transformar
            fields=self.fields
        else:
            fields=[]
            
        for f in fields:
            df[f]=df[f].map(lambda x: self.remove_html_tags(x))
            
        if self.has_attribute('regex'): #expresión regular para eliminar de los datos
            regexes=self.regex
        else:
            regexes=((r'\\n',' '),(r'\n',' '))
            
        df=self.remove_line_break(df,regexes=regexes)
        
        self.df=df





