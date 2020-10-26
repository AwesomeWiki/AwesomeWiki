/* eslint-disable */
import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import LanguageSelect from '@/components/LanguageSelect'
import CategorySelect from '@/components/CategorySelect'
import LibrarySelect from '@/components/LibrarySelect'
import Library from '@/components/Library'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
    },
    {
      path: '/languages',
      name: 'LanguageSelect',
      component: LanguageSelect
    },
    {
      path: '/:language/categories',
      name: 'CategorySelect',
      component: CategorySelect
    },
    {
      path: '/:language/:category/libraries',
      name: 'LibrarySelect',
      component: LibrarySelect,
    },
    {
      path: '/:language/:category/:library',
      name: 'Library',
      component: Library
    }
  ]
})
