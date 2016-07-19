from __future__ import absolute_import, unicode_literals

import unittest

from draftjs_exporter.entities.link import Link


class TestLink(unittest.TestCase):
    def setUp(self):
        self.link = Link()

    def test_init(self):
        self.assertIsInstance(self.link, Link)

    def test_render(self):
        link = self.link.render({
            'data': {
                'url': 'http://example.com',
            }
        })
        self.assertEqual(link.tag, 'a')
        self.assertEqual(link.text, None)
        self.assertEqual(link.get('href'), 'http://example.com')

    def test_render_invalid(self):
        link = self.link.render({
            'data': {
                'url': 'http://example.com',
                'disabled': 'true',
            }
        })
        self.assertEqual(link.get('disabled'), None)
