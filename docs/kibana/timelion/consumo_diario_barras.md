# Gráfica de promedios diarios (barras), resaltando máximo y mínimo, + consumo mes anterior
.es(q='dia_semana:(5 OR 6)',metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=_root)
.bars(width=25).color('#EBFFB3').label('Findesemana'),

.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=_root)
.if(gt,
.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=_root).aggregate(min)
,.es(q='dia_semana:(((0 OR 1) OR (2 OR 3)) OR 4)',metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=_root),

.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=_root)
.if(gt,
.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=_root).fit(none).aggregate(min)
,.es(q='dia_semana:(((0 OR 1) OR (2 OR 3)) OR 4)',metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=_root,fit=none), 
null)

)
.bars(width=25).color('#00B371').label('Consumo Diario')
,




.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=_root)
.if(eq,
.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=_root).fit(none).aggregate(min)
,.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=_root), 
null).bars(width=25).color('#505050').label('Mínimo'),

.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=_root)
.if(eq,
.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=_root).fit(none).aggregate(max)
,.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=_root), 
null)
.bars(width=25).color('#A90000').label('Máximo'),

.es(metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=_root).fit(none).aggregate(avg).color('#003C89').label('Promedio').legend(columns=5)
,

.es(q='mes:11',metric='sum:Kwh(ep1)',timefield='rootTimeStamp', index=_root,offset=-28d).color('#505050').label('Noviembre').points(show=true).lines(show=true)