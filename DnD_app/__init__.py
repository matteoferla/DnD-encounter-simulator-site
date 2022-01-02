from pyramid.config import Configurator
from pyramid.router import Router


def main(global_config, **settings) -> Router:
    """ This function returns a Pyramid WSGI application.
    """
    return create_app(**settings)

def create_app( **settings) -> Router:
    with Configurator(settings=settings) as config:
        config.include('pyramid_mako')
        config.include('.routes')
        config.scan()
        return config.make_wsgi_app()
