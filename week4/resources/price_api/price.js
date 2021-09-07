var 
	express = require("express"),
	bodyParser = require("body-parser"),
	cors = require("cors"),
	config = {
	    name_str: "price",
	    port_int: 3000,
	    host_str: "0.0.0.0"
	},
	app = express();
app.use(bodyParser.json());
app.use(cors());
app.get("/", (req, res) => {
	res.status(200).send("hello this is the root of the price api");
});
//for when we use path based routing
app.get("/price/get-prices", getPrices);
app.get("/get-prices", getPrices);
//our main function
function getPrices(req, res){
	var 
		payload = {
			price_arr: ["134.50", "455.99"]
		};
	res.status(200).json(payload);
	console.log("returning prices");
}
app.listen(config.port_int, config.host_str, (e)=> {
    if(e) {
        throw new Error("Internal Server Error");
    }
    console.log("Running the " + config.name_str + " app");
});