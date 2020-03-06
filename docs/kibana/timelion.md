## Ejemplos Time-lion

* 


# Gráfica de promedios diarios (barras), resaltando máximo y mínimo

.es(metric='sum:Kwh(ep1)',timefield='timeStamp', index=,fit=none)
.if(gt,
.es(metric='sum:Kwh(ep1)',timefield='timeStamp', index=).fit(none).aggregate(min)
,.es(q='dia_semana:(((0 OR 1) OR (2 OR 3)) OR 4)',metric='sum:Kwh(ep1)',timefield='timeStamp', index=,fit=none),

.es(metric='sum:Kwh(ep1)',timefield='timeStamp', index=,fit=none)
.if(gt,
.es(metric='sum:Kwh(ep1)',timefield='timeStamp', index=).fit(none).aggregate(min)
,.es(q='dia_semana:(((0 OR 1) OR (2 OR 3)) OR 4)',metric='sum:Kwh(ep1)',timefield='timeStamp', index=,fit=none), 
null)

)
.bars(width=25).label('Consumo Diario')
,


.es(q='dia_semana:(5 OR 6)',metric='sum:Kwh(ep1)',timefield='timeStamp', index=).bars(width=25).color('#EBFFB3').label('Findesemana'),

.es(metric='sum:Kwh(ep1)',timefield='timeStamp', index=,fit=none)
.if(eq,
.es(metric='sum:Kwh(ep1)',timefield='timeStamp', index=).fit(none).aggregate(min)
,.es(metric='sum:Kwh(ep1)',timefield='timeStamp', index=,fit=none), 
null).bars(width=25).color('#505050').label('Mínimo'),

.es(metric='sum:Kwh(ep1)',timefield='timeStamp', index=,fit=none)
.if(eq,
.es(metric='sum:Kwh(ep1)',timefield='timeStamp', index=).fit(none).aggregate(max)
,.es(metric='sum:Kwh(ep1)',timefield='timeStamp', index=,fit=none), 
null).bars(width=25).color('#A90000').label('Máximo'),

.es(metric='sum:Kwh(ep1)',timefield='timeStamp', index=).fit(none).aggregate(avg).color('#003C89').label('Promedio').legend(columns=5)
,


# Gráfica de promedios diarios (barras), resaltando máximo y mínimo, + consumo mes anterior
.es(q='dia_semana:(5 OR 6)',metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=)
.bars(width=25).color('#EBFFB3').label('Findesemana'),

.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=)
.if(gt,
.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=).aggregate(min)
,.es(q='dia_semana:(((0 OR 1) OR (2 OR 3)) OR 4)',metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=),

.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=)
.if(gt,
.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=).fit(none).aggregate(min)
,.es(q='dia_semana:(((0 OR 1) OR (2 OR 3)) OR 4)',metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=,fit=none), 
null)

)
.bars(width=25).color('#00B371').label('Consumo Diario')
,




.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=)
.if(eq,
.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=).fit(none).aggregate(min)
,.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=), 
null).bars(width=25).color('#505050').label('Mínimo'),

.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=)
.if(eq,
.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=).fit(none).aggregate(max)
,.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=), 
null)
.bars(width=25).color('#A90000').label('Máximo'),

.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=).fit(none).aggregate(avg).color('#003C89').label('Promedio').legend(columns=5)
,

.es(q='mes:11',metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=,offset=-28d).color('#505050').label('Noviembre').points(show=true).lines(show=true)

# Gráfica comparando dos meses



.es(q='dia_semana:(5 OR 6)',metric='sum:Kwh(ep1)',timefield='timeStamp', index=).bars().color('#EBFFB3').label('Findesemana'),

.es(q='dia_semana:(<5)',metric='sum:Kwh(ep1)',timefield='timeStamp', index=).bars().color('#C9DDFF').label('Semana'),

.es(q='mes:10',metric='sum:Kwh(ep1)',timefield='timeStamp', index=).color('#A90000').label('Octubre'),

.es(q='mes:9',metric='sum:Kwh(ep1)',timefield='timeStamp', index=,offset=-28d).color('#505050').label('Septiembre'),


# Gráfica comparando dos meses ALT

#https://stackoverflow.com/questions/44412459/kibana-timelion-how-to-add-vertical-line

.es(q='dia_semana:(5 OR 6)',metric='min:Kwh(ep1)',timefield='timeStamp', index=).add(3000).bars(width=39).color('#EBFFB35E').label('Findesemana').yaxis(1,min=0,max=3000,null,''),


.es(q='mes:9',metric='sum:Kwh(ep1)',timefield='timeStamp', index=,offset=-28d).color('#000ed4').label('Septiembre').legend(columns=5),

.es(q='mes:10',metric='sum:Kwh(ep1)',timefield='timeStamp', index=).color('#A90000').label('Octubre'),




# Gráfica de los dos meses

.es(q='dia_semana:(5 OR 6)',metric='sum:Kwh(ep1)',timefield='timeStamp', index=).divide(1000).bars().color('#EBFFB3').label('Findesemana'),

.es(q='dia_semana:(<5)',metric='sum:Kwh(ep1)',timefield='timeStamp', index=).divide(1000).bars().color('#C9DDFF').label('Semana'),

.es(q='mes:10',metric='sum:Kwh(ep1)',timefield='timeStamp', index=).fit(none).if(gt,0, .es(q='mes:10',metric='sum:Kwh(ep1)',timefield='timeStamp', index=).divide(1000),null)
.color('#C20000').label('Octubre'),

.es(q='mes:9',metric='sum:Kwh(ep1)',timefield='timeStamp', index=).if(gt,0,.es(q='mes:9',metric='sum:Kwh(ep1)',timefield='timeStamp', index=).divide(1000),null)
.color('#00102B').label('Septiembre'),

## Gráfica de Media Móvil y Suavizado Exponencial

.es(q='dia_semana:(5 OR 6)',metric='avg:ep1',timefield='timeStamp', index=).bars().color('#EBFFB3').divide(1000).label('Findesemana'),

.es(q='dia_semana:(<5)',metric='avg:ep1',timefield='timeStamp', index=).bars().color('#C9DDFF').divide(1000).label('Semana'),

.es(metric='avg:ep1',timefield='timeStamp', index=).fit(none).divide(1000).mvavg(7d).color('#001225').label('Media Móvil'),

.es(metric='avg:ep1',timefield='timeStamp', index=).fit(none).divide(1000).holt(season=1w,sample=2,alpha=0.1).color('#A12500').label('Exponencial - Holt (Intervalo 1 Semana)'),

## Gráfica de Derivada

.es(q='mes:10',metric='avg:ep1',timefield='timeStamp', index='')
.if(gt,0,
.es(q='mes:10',metric='avg:ep1',timefield='timeStamp', index='').divide(1000).fit(none).mvavg(7d,position='center').derivative(), 

null).lines(fill=5).color('#004A6F').label('Octubre'),

.es(q='mes:9',metric='avg:ep1',timefield='timeStamp', index='')
.if(gt,0,
.es(q='mes:9',metric='avg:ep1',timefield='timeStamp', index='').divide(1000).fit(none).mvavg(7d,position='center').derivative(), 

null).lines(fill=5).color('#A0B200').label('Septiembre'),


.static(0).color('#B21800')


# Gráfica de Tendencias (Regresión)

.es(q='dia_semana:(<5) AND mes:10',metric='avg:ep1',timefield='timeStamp', index=).label('Octubre').points(),

.es(q='dia_semana:(<5) AND mes:9',metric='avg:ep1',timefield='timeStamp', index=).label('Septiembre').points(),

.es(q='dia_semana:(<5) AND mes:10',metric='avg:ep1',timefield='timeStamp', index=).trend(mode='log').label('Tendencia Octubre'),

.es(q='dia_semana:(<5) AND mes:9',metric='avg:ep1',timefield='timeStamp', index=).trend(mode='log').label('Tendencia Septiembre'),

.es(q='dia_semana:(<5)',metric='avg:ep1',timefield='timeStamp', index=).trend(mode='log').label('Tendencia General'),


# Análisis de Series Temporal

.es(q='dia_semana:(>=5)',metric='avg:ep1',timefield='timeStamp', index=).bars().label('Fin de Semana'),

.es(q='mes:10',metric='avg:ep1',timefield='timeStamp', index=).label('Octubre'),

.es(q='mes:9',metric='avg:ep1',timefield='timeStamp', index=).label('Septiembre'),

.es(metric='avg:ep1',timefield='timeStamp', index=).fit(scale).mvavg(7d).label('Media Móvil'),

