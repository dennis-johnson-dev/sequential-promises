var chai = require("chai");
var chaiAsPromised = require("chai-as-promised");

chai.expect();
chai.use(chaiAsPromised);

global.chaiAsPromised = chaiAsPromised;
global.expect = chai.expect;
