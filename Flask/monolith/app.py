from website import app
import static.config as config


if __name__ == '__main__':
    if config.PROD_ENV:
        from waitress import serve
        serve(app, host=config.HOST, port=config.PORT, threads=config.THREAD_POOL_SIZE)
    else:
        app.run(host=config.HOST, port=config.PORT, debug=config.DEBUG)
