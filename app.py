import psutil
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/api/stats')
def get_stats():
    cpu_percent = psutil.cpu_percent()
    mem = psutil.virtual_memory()
    mem_percent = mem.percent
    return jsonify(cpu_percent=cpu_percent, mem_percent=mem_percent)

if __name__ == '__main__':
    app.run()

