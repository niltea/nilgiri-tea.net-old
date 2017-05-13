import riot from 'riot';
import route from 'riot-route';
import RiotControl from 'riotcontrol';

import Action from '../Action/Action';
import Store from '../Store/Store';
import Constant from "../Constant/Constant";

<niltea-base>
	<section class='header' ref='header'></section>
	<section class='content' ref='content'></section>
	<section class='footer' ref='footer'></section>
	<script>
		const self = this;

	self.on('mount', () => {
		riot.mount(self.refs.header, 'niltea-header');
		riot.mount(self.refs.footer, 'niltea-footer');
	});


	// routing
	route.base('/');
	// indexで取得する記事数
	const limit = Constant.indexPostLimit;
	// Indexのロード
	route('/', () => {
		riot.mount(self.refs.content, 'niltea-index');
		Action.loadContent({type: 'posts', query: {limit}});
		// document.title = `${Store.blogInfo.title}`;
		Action.setCurrent({current: 'index', page: 1});
	});
	// index / pagenation
	route('/index/*', (page) => {
		riot.mount(self.refs.content, 'niltea-index');
		Action.loadContent({type: 'posts', query: {limit, offset: limit * (page - 1)}});
		// document.title = `${Store.blogInfo.title}`;
		Action.setCurrent({current: 'index', page: page});
	});

	// post
	route('/post/*', (id) => {
		riot.mount(self.refs.content, 'niltea-post');
		Action.loadContent({type: 'posts', query: {id}});
		Action.setCurrent({current: 'posts', id});
	});

	// about
	route('/about', () => {
		riot.mount(self.refs.content, 'niltea-about')
		if (!Store.blogInfo) Action.loadContent({type: 'info'});
		// document.title = `about | ${Store.blogInfo.title}`;
		Action.setCurrent({current: 'about'});
	});

	// default
	route('*', () => {route('/')});
	route.start(true);

</script>
</niltea-base>