
import os
import json
from flask import Flask, request, jsonify
#from flask_cors import CORS

app = Flask(__name__)
#cors = CORS(app)


port = int(os.getenv('PORT','3000'))

@app.route('/')
def index():
    print(json.dumps(dict(request.headers)))
    return json.dumps(dict(request.headers))



@app.route('/certcheck')
def index2():
    response = "certcheck ";
    
    print(json.dumps(dict(request.headers)))
    return json.dumps(dict(request.headers))


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=port)
