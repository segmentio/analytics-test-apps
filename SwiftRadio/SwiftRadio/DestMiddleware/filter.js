function filterTransform(input) {
    var result = tsub.transform(input, [{
                'type': 'drop_properties',
                'config': {'drop': {'': ['removeMe']}}
                }]);
    return result;
}
