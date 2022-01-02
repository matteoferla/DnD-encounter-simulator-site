## Webserver
This is the webserver files for the [D&D encounter simulator](https://github.com/matteoferla/DnD-battler)... 
where one sets one's team to battle dragons and tarrasques.

It is hosted at [dnd.matteoferla.com](dnd.matteoferla.com) on my homeserver.

It has had several iterations. It actually was my first go with Pyramid on Openshift.

As present here is not actually the live version, which runs off older code.


If you were looking for the python module to similate locally all the encounters you fancy, then you need to check out the [DnD encounter similator  GitHub repository](https://github.com/matteoferla/DnD-battler).

## Example

```python
import DnD_app
import waitress
from pyramid.router import Router

app :Router = DnD_app.create_app()
waitress.serve(app, port=6666)
```
