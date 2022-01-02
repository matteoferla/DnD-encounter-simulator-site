from pyramid.config import Configurator

def includeme(config: Configurator):
    config.add_static_view('static', 'static', cache_max_age=3600)
    config.add_route('home', '/') # /dnd in combined server
    config.add_route('review', '/review')  # /dnd-review
    config.add_route('simulate', '/simulate')  # /ajax_dnd
    config.add_route('lineup', '/lineup')  # /ajax_lineup
