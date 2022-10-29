from setuptools import setup

setup(
    name='gridradpy',
    version='0.1',
    author='Tim Supinie, Cameron Homeyer',
    author_email='tsupinie@gmail.com',
    description='GridRad data software',
    license='GPLv3',
    keywords='meteorology radar analysis',
    url='https://github.com/tsupinie/gridradpy',
    packages=['gridradpy'],
    scripts=['bin/download_gridrad']
)