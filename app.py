from flask import Flask, jsonify
app = Flask(__name__)

@app.route("/health")
def hello():
    return jsonify({'status': 'ok'})

if __name__ == "__main__":
    app.run(host='0.0.0.0')

