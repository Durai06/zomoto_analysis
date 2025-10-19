from flask import Flask, request, jsonify, send_from_directory
import mysql.connector
app = Flask(__name__)

def create_connection():
    return mysql.connector.connect(user='root',
                                   password='masterrd',
                                   host='localhost',
                                   database='zomoto')
@app.route('/')
def index():
    return send_from_directory('static', 'index.html')

@app.route('/place_order', methods=['POST'])
def place_order():
    data = request.get_json()

    cart = data['cart']
    address = data['address']
    print(data)
    print(cart)

    if not cart or not address:
        return jsonify({"data is empty"})

    connection = create_connection()
    cursor  = connection.cursor()

    for item in cart:
        item_name = item['name']
        quantity = item['quantity']

        cursor.execute("select item_id from items where item_name = %s",(item_name,))
        result = cursor.fetchone()

        if result is None:
            return jsonify({"data is empty"})

        item_id = result[0]
        user_id = 1

        insert_query = """insert into orders(user_id, item_id, quantity, delivery_address)
                        values(%s, %s, %s, %s)"""

        cursor.execute(insert_query, [user_id, item_id, quantity, address])
    connection.commit()
    return jsonify({"message": "Order placed successfully!"}), 200


@app.route('/orders', methods = ['GET'])
def get_orders():
    try:
        connection = create_connection()
        cursor = connection.cursor()
        cursor.execute("select * from orders")
        result = cursor.fetchall()

        return jsonify({"data is ok"}),200
    except Exception as e:
        return jsonify({"data is error"}),500
    finally:
        connection.close()

if __name__ == '__main__':
    app.run(debug=True)
