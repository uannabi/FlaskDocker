var 
	express = require("express"),
	bodyParser = require("body-parser"),
	cors = require("cors"),
	config = {
	    name_str: "service",
	    port_int: 3000,
	    host_str: "0.0.0.0"
	},
	app = express();
app.use(bodyParser.json());
app.use(cors());
app.get("/", (req, res) => {
	res.status(200).send("hello this is the root of the service api");
});
//for when we use path based routing
app.get("/service/get-service-area", getServiceArea);
app.get("/get-service-area", getServiceArea);
//our main function
function getServiceArea(req, res){
	var 
		payload = {
			cities_arr: ["vegas", "chicago"]
		};
	res.status(200).json(payload);
	console.log("returning cities");
};
app.listen(config.port_int, config.host_str, (e)=> {
    if(e) {
        throw new Error("Internal Server Error");
    }
    console.log("Running the " + config.name_str + " app");
});