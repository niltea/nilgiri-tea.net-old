import RiotControl from 'riotcontrol';

import Store from '../Store/Store';
<niltea-post>
	<div id="post">
		<!-- Photo -->
		<div class="photoContainer" if={photos}>

			<a class="photo" if={!isPhotoSet} each={photos} href='{original_size.url}'>
				<img src="{alt_sizes[0].url}" alt="">
			</a>
			<a class="photo photoSetItem" if={isPhotoSet} each={photos} href='{original_size.url}'>
				<img src="{alt_sizes[0].url}" alt="">
			</a>
		</div>
		<span>{caption}</span>
	</div>

	<script>
		const self = this;
		const contentKeys = [
			'id',
			'caption',
			'title',
			'date',
			'type',
			'url',
			'photos',
		];
		this.isPhotoSet = false;

		self.on('unmount', () => {
			RiotControl.off(Store.ActionTypes.changed);
		});

		// Subscribes Store.onChanged
		RiotControl.on(Store.ActionTypes.changed, () => {
			const content = Store.content[0];
			console.log(content)
			contentKeys.forEach(key => { this[key] = content[key] });
			// photosが複数であればphososetであると判断
			this.isPhotoSet = (this.photos.length > 1);
			riot.update();
		});

	</script>
</niltea-post>