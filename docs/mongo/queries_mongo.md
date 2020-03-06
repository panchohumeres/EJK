## stats company hour, filtrar por _id ({id_companía:fecha+hora})

db.getCollection('stats-companyHour').find({"_id":{'$regex':'.*5b98228bc81109617b3051f1:2019120301.*'}})


db.getCollection('stats-companyHour').aggregate([
  {$match:
    {'GENDER': 'F',
     'DOB':
      { $gte: 19400801,
        $lte: 20131231 } } },
  {$group:
     {_id: "$GENDER",
     totalscore:{ $sum: "$BRAINSCORE"}}}
])


db.getCollection('monitors').find({"_id":{'$regex':'.*228401:2019122207.*'}})


db.getCollection('monitors').aggregate([
  {$regexMatch:
    {"_id":{'$regex':'.*228401:20191222.*'}}},
  {$group:
     {_id: "$_id",
     totalscore:{ $sum: "$ep1"}}}
])

## aplanar el listado 

db.getCollection('monitors').aggregate([
  {$match:
    {"_id":/228401:20191222/}},
    {$unwind: { path: "$sizes", preserveNullAndEmptyArrays: true }},
  {$group:
     {_id: "$_id",
     totalscore:{ $sum: "$ep1"}}}
])

## filtrar las locaciones por id de la companía

db.getCollection('locations').find({'companyId':ObjectId('5b98228bc81109617b3051f1')})

## por locación, encontrar los ids únicos de los sensores

db.getCollection('locations').aggregate([
  {$match:
    {'companyId':ObjectId('5b98228bc81109617b3051f1')}},
    {$unwind: { path: "$meters", preserveNullAndEmptyArrays: true, includeArrayIndex: "arrayIndex"}},
      {$group:
     {_id: null,
     uniqueValues: {$addToSet: "$meters"}}}
])

## por locacion, regex find(), y agregación, para un mes

db.getCollection('monitors').aggregate([
  {$match:
    {"_id":{'$regex':'.*228401:201912.*'}}},
    {$unwind: { path: "$sizes", preserveNullAndEmptyArrays: true }},
  {$group:
     {_id: "$_id",
     totalscore:{ $sum: "$ep1"}}}
])


## por locación, encontrar los ids únicos de los sensores, + dejarlo como arreglo (pymongo)

pipeline=[
    
  {"$match":
    {'companyId':ObjectId('5b98228bc81109617b3051f1')}},
    {"$unwind": { "path": "$meters", "preserveNullAndEmptyArrays": True, "includeArrayIndex": "arrayIndex"}},
      {"$group":
     {"_id": None,
     "uniqueValues": {"$addToSet": "$meters"}}},
    {"$unwind": { "path": "$uniqueValues", "preserveNullAndEmptyArrays": True}}
]