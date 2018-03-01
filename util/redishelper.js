/**
 * @Author: snail
 * @Date:   2016-12-10 10:00:00
 * @Last Modified by:
 * @Last Modified time:
 * @Function:redis帮助方法
 */
var redis = require('redis');

var config = appRequire('config/config');

var redisCache = function() {
    try {
        var client  = redis.createClient(config.isdev ? config.redis_local : config.redis_prd);
        // redis 链接错误
        client.on("error", function(error) {
            console.log("出错了");
            console.log(error);
        });
        console.log(client);
        console.log("redis是否连接成功=> " + client.connected);
        console.log(typeof client);
        this._redis = this._redis ? this._redis : client;
    } catch (exception) {
        console.log(exception);
    }

};

//获取所有的redis的键
redisCache.prototype.keys = function(k, fn) {
    var connected = this._redis.connected;
    if (!connected) {
        return fn(true,null);
    }
    console.log("redisCache.prototype.keys()是否连接成功=> " + connected);
    this._redis.keys(k, fn);
}

//获取某个redis的键对应的值
redisCache.prototype.get = function(k, fn) {
    var connected = this._redis.connected;
    if (!connected) {
        return fn(true,null);
    }
    console.log("redisCache.prototype.get()是否连接成功=> " + connected);
    this._redis.get(k, fn);
};

//设置某个redis的键的值
redisCache.prototype.set = function(k, v, fn) {
    var connected = this._redis.connected;
    if (!connected) {
        return fn(true,null);
    }
    console.log("redisCache.prototype.set()是否连接成功=> " + connected);
    this._redis.set(k, v, fn);
};

//将某个redis的键设置为N秒过期
redisCache.prototype.expire = function(k, interval) {
    var connected = this._redis.connected;
    if (!connected) {
        return interval(true,null);
    }
    console.log("redisCache.prototype.expire()是否连接成功=> " + connected);
    this._redis.expire(k, interval);
};

//删除某个键的值
redisCache.prototype.del = function(k, fn) {
    var connected = this._redis.connected;
    if (!connected) {
        return fn(true,null);
    }
    console.log("redisCache.prototype.expire()是否连接成功=> " + connected);
    this._redis.del(k, fn);
};

redisCache.prototype.hset = function(k, f, v, fn) {
    var connected = this._redis.connected;
    if (!connected) {
        return fn(true,null);
    }
    console.log("redisCache.prototype.expire()是否连接成功=> " + connected);
    if (this._redis.hset === undefined) {
        fn(Error(), null);
    } else {
        this._redis.hset(k, f, v, fn);
    }
};

redisCache.prototype.hget = function(k, f, fn) {
    var connected = this._redis.connected;
    console.log("redisCache.prototype.expire()是否连接成功=> " + connected);
    if (!connected) {
        return fn(true,null);
    }

    if (this._redis.hget === undefined) {
        fn(Error(), null);
    } else {
        this._redis.hget(k, f, fn);
    }
};

redisCache.prototype.multiDel = function(k, fn) {
    var connected = this._redis.connected;
    console.log("redisCache.prototype.multiDel()是否连接成功=> " + connected);
    if (!connected) {
        return fn(true,null);
    }

    var multi = this._redis.multi();
    _.each(k, function(row) {
        multi.del(row);
    });
    multi.exec();
};

module.exports = redisCache;