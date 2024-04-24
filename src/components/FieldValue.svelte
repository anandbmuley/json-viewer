<script lang="ts">
	export let value: any;
	function changeColorByValueType(value: any): string {
		if (typeof value === 'string') {
			return 'text-primary';
		} else if (typeof value === 'number') {
			return 'text-success';
		} else if (typeof value === 'boolean') {
			return 'text-danger';
		} else if (typeof value === 'object') {
			return 'text-warning';
		} else {
			return 'text-secondary';
		}
	}

	function getColorCodeByValueType(value: any): string {
		if (typeof value === 'string') {
			return '#9900ff';
		} else if (typeof value === 'number') {
			return '#9900ff';
		} else if (typeof value === 'boolean') {
			return '#9900ff';
		} else if (typeof value === 'object') {
			return '#9900ff';
		} else {
			return 'gray';
		}
	}
</script>

<span style={'color:' + getColorCodeByValueType(value)}>{value}</span>
