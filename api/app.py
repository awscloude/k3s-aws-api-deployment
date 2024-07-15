from flask import Flask, jsonify, request

app = Flask(__name__)

# GET endpoint
@app.route('/hello', methods=['GET'])
def hello_world():
    return jsonify(message="Hello, World!")

# POST endpoint
@app.route('/echo', methods=['POST'])
def echo():
    data = request.get_json()
    return jsonify(data)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')

