// library.js

addToLibrary({
    _posix_spawn_js: () => {
        console.log('_posix_spawn_js has been called in library.js');
        return 0;
    },
    not_posix_spawn: () => {
        console.log('not_posix_spawn has been called in library.js');
        return 0;
    },
});
