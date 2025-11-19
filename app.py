from flask import Flask, jsonify
import psycopg2
import os

app = Flask(__name__)

# Database configuration from environment variables
DB_HOST = os.getenv('DB_HOST', 'localhost')
DB_PORT = os.getenv('DB_PORT', '5432')
DB_NAME = os.getenv('DB_NAME', 'greencheck')
DB_USER = os.getenv('DB_USER', 'postgres')
DB_PASSWORD = os.getenv('DB_PASSWORD', 'postgres')


def get_db_connection():
    """Create and return a database connection."""
    conn = psycopg2.connect(
        host=DB_HOST,
        port=DB_PORT,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD
    )
    return conn


@app.route('/')
def index():
    """Home route."""
    return jsonify({
        'message': 'Welcome to GreenCheck API',
        'status': 'running'
    })


@app.route('/health')
def health():
    """Health check route."""
    try:
        conn = get_db_connection()
        conn.close()
        return jsonify({
            'status': 'healthy',
            'database': 'connected'
        })
    except Exception as e:
        return jsonify({
            'status': 'unhealthy',
            'database': 'disconnected',
            'error': str(e)
        }), 500


@app.route('/users')
def get_users():
    """Get all users from the database."""
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT id, name, email, created_at FROM users ORDER BY id;')
        users = cur.fetchall()
        cur.close()
        conn.close()
        
        users_list = []
        for user in users:
            users_list.append({
                'id': user[0],
                'name': user[1],
                'email': user[2],
                'created_at': user[3].isoformat() if user[3] else None
            })
        
        return jsonify({
            'users': users_list,
            'count': len(users_list)
        })
    except Exception as e:
        return jsonify({
            'error': str(e)
        }), 500


if __name__ == '__main__':
    # Run the app
    # Use 0.0.0.0 to make it accessible from outside the container
    # Debug mode is controlled by FLASK_DEBUG environment variable (defaults to False)
    # NOTE: This direct execution is only for development. Production uses Gunicorn.
    debug_mode = os.getenv('FLASK_DEBUG', '0') == '1'
    app.run(host='0.0.0.0', port=5000, debug=debug_mode)
